import fs from "fs";
import { KarabinerRule } from "./types";
import { createHyperSubLayers, app, open, withHyperKey, createHyperKey, quickCommandMap } from "./utils";

const rules: KarabinerRule[] = [
  // Top-level keys
  {
    description: "Top-level keys",
    manipulators: [
      createHyperKey({
        keyCode: "tab",
        restoreKeyFunction: true,
      }),
      createHyperKey({
        keyCode: "w",
        modifiers: {
          mandatory: ["shift", "command"]
        }
      }),
      {
        description: "Caps -> Esc (press)/Ctrl (hold)",
        from: {
          key_code: "caps_lock",
          modifiers: {
            optional: ["any"]
          }
        },
        type: "basic",
        to: [
          { key_code: "left_control", lazy: true }
        ],
        to_if_alone: [
          { key_code: "escape" }
        ],
      },
    ],
  },
  withHyperKey('f', {
    description: "FN",
    to: [
      { key_code: 'fn' }
    ]
  }),
  quickCommandMap("r", "/opt/homebrew/bit/brew services restart yabai"),

  quickCommandMap("h", "/opt/homebrew/bin/yabai -m window --focus west"),
  quickCommandMap("j", "/opt/homebrew/bin/yabai -m window --focus south"),
  quickCommandMap("k", "/opt/homebrew/bin/yabai -m window --focus north"),
  quickCommandMap("l", "/opt/homebrew/bin/yabai -m window --focus east"),

  quickCommandMap("y", "/opt/homebrew/bin/yabai -m space --mirror y-axis"),
  quickCommandMap("u", "/opt/homebrew/bin/yabai -m space --mirror x-axis"),
  quickCommandMap("m", "/opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen"),
  quickCommandMap("e", "/opt/homebrew/bin/yabai -m space --balance"),
  quickCommandMap("f", "/opt/homebrew/bin/yabai -m window --toggle float --grid 4:4:1:1:2:2"),
  quickCommandMap("f5", "~/.config/scripts/layout com.apple.keylayout.US"),
  quickCommandMap("f6", "~/.config/scripts/layout com.apple.keylayout.RussianWin"),

  ...createHyperSubLayers({
    // Navigation
    q: {
      h: { to: [{ key_code: 'left_arrow' }] },
      j: { to: [{ key_code: 'down_arrow' }] },
      k: { to: [{ key_code: 'up_arrow' }] },
      l: { to: [{ key_code: 'right_arrow' }] },
      u: { to: [{ key_code: 'page_down' }] },
      p: { to: [{ key_code: 'page_up' }] },
    },
    o: {
      b: app('Arc'),
      t: app('kitty'),
      s: app('Spotify'),
      o: app('Telegram'),
      e: app('Slack'),
      n: app('Notion'),
      f: app('Raycast'),
      m: open('https://meet.google.com/')
    },
    s: {
      u: {
        description: "Volume Up",
        to: [{ key_code: 'volume_decrement' }],
      },
      i: {
        description: "Volume Down",
        to: [{ key_code: 'volume_increment' }],
      },
      j: {
        description: "Brightness Down",
        to: [{ key_code: 'display_brightness_decrement' }],
      },
      k: {
        description: "Brightness Up",
        to: [{ key_code: 'display_brightness_increment' }],
      },
    },
    w: {
      r: { to: [{ shell_command: "/opt/homebrew/bit/brew services restart yabai" }] },

      // Switch windows
      j: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m window --focus south" }] },
      k: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m window --focus north" }] },
      h: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m window --focus west" }] },
      l: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m window --focus east" }] },

      // Manipulate windows
      y: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m space --mirror y-axis" }] },
      u: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m space --mirror x-axis" }] },
      m: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m window --toggle zoom-fullscreen" }] },
      e: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m space --balance" }] },
      f: { to: [{ shell_command: "/opt/homebrew/bin/yabai -m window --toggle float --grid 4:4:1:1:2:2" }] },
    },
    e: {
      p: { to: [{ key_code: 'play_or_pause' }] },
      n: { to: [{ key_code: 'fastforward' }] },
      b: { to: [{ key_code: 'rewind' }] },
      m: { to: [{ key_code: 'mute' }] },
    }
  })
];

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: {
        show_in_menu_bar: false,
      },
      profiles: [
        {
          name: "Default",
          complex_modifications: {
            rules,
          },
        },
      ],
    },
    null,
    2
  )
);
