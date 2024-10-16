import fs from "fs";
import { KarabinerRule } from "./types";

const rules: KarabinerRule[] = [
  // Top-level keys
  {
    description: "Top-level keys",
    manipulators: [
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
