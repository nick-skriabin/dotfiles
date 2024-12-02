{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # For controlling Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core
    , homebrew-cask, homebrew-bundle }:
    let
      configuration = { pkgs, config, ... }: {
        # Allow installing "unfree" (closed-source) packages e.g. Obsidian
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          #### Terminal stuff
          # Terminal emulator
          pkgs.kitty
          # Terminal multiplexer
          pkgs.tmux
          # I use (neo)vim, btw
          pkgs.neovim

          ### Tools
          # Nix files formatter
          pkgs.nixfmt-classic
          pkgs.aerospace
          pkgs.automake117x
          pkgs.btop # better top
          pkgs.bat # better cat
          pkgs.blueutil # cli to interact with bluetooth
          pkgs.bun # JS/TS runtime
          pkgs.cargo # rust package manager/compiler
          pkgs.cmake
          pkgs.deno
          pkgs.delta
          pkgs.emscripten
          pkgs.eza # better ls
          pkgs.fd # file finder
          pkgs.fswatch # FS events
          pkgs.fzf # Fuzzy search for everything
          pkgs.gitmux # Git status for TMUX
          pkgs.gh # Github tools
          pkgs.gleam
          pkgs.go
          pkgs.hub # GitHub tools
          pkgs.jankyborders # Border around active window
          pkgs.jq # JSON formatter and query engine
          pkgs.lazydocker # TUI for docker
          pkgs.lazygit # TUI for git
          pkgs.luajit
          pkgs.markdownlint-cli
          pkgs.maven
          pkgs.mdformat
          pkgs.obsidian
          pkgs.pass
          pkgs.pipx
          pkgs.pnpm
          pkgs.poetry
          pkgs.redis
          pkgs.ripgrep # Better grep
          pkgs.ruff # Python linter
          pkgs.rustc # Rust programming language
          pkgs.slack # Messenger
          pkgs.spotify # Some music?
          pkgs.silver-searcher # Code finder (ag)
          pkgs.supabase-cli
          pkgs.tree-sitter # AST builder
          pkgs.wget
          pkgs.wireguard-tools
          pkgs.xh # Better cURL
          pkgs.yazi # File manager
          pkgs.zoxide # Better cd
          pkgs.zoom-us
        ];

        fonts.packages = [ pkgs.nerd-fonts.fira-code ];

        # Managing packages installed via homebrew
        homebrew = {
          enable = true;
          taps = [
            # QMK firmware stuff
            "qmk/qmk"
            # Sketchybar and friends
            "FelixKratz/formulae"
          ];
          brews = [
            "git"
            "hookdeck/hookdeck/hookdeck"
            "ifstat" # network interface stats
            "luarocks"
            "nvm"
            "qmk/qmk/qmk"
            "urlview"
            "xcodegen"
            {
              name = "sketchybar";
              start_service = true;
            }
            {
              name = "borders";
              start_service = true;
            }
          ];
          casks = [
            "arc"
            "blender"
            "chatgpt"
            "hammerspoon"
            "homerow"
            "figma"
            "discord"
            "keymapp"
            "logi-options+"
            "marta"
            "miro"
            "nordpass"
            "notion"
            "notion-calendar"
            "orbstack"
            "raycast"
            "sf-symbols"
            "shapr3d"
            "maccy"
            "steam"
            "telegram"
            "affinity-designer"
            "affinity-photo"
            "chromedriver"
            "whisky"
            "font-hack-nerd-font"
            "font-sf-pro"
            "kindavim"
          ];
          # Installed from App Store
          # You must be logged in and an app must already be purchased
          masApps = {
            PDFGear = 6469021132;
            iWallpaper = 1552826194;
            AdGuard = 1440147259;
            XCode = 497799835;
          };
          onActivation = { cleanup = "zap"; };
        };

        services = {
          aerospace = {
            enable = false;
            # start-at-login = true;
          };
        };

        # Nix uses symlinks for GUI apps by default. This makes
        # Spotlight kinda useless. This activation script will
        # make sure that Nix uses aliases instead of symlinks
        system.activationScripts.applications.text = let
          env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
          };
        in pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
                    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#nsmbp-2
      darwinConfigurations."nsmbp-2" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Only for Apple Silicon (M-series)
              enableRosetta = true;
              # User (specify your system user)
              user = "nicholasrq";
              # Remove/comment the following line if
              # you're starting from scratch (no homebrew installed)
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
