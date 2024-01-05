import { To, KeyCode, Manipulator, KarabinerRule, Modifiers, From } from "./types";

export const HyperKeyModifiers: KeyCode[] = ["left_command", "left_control", "left_option"];
/**
 * Custom way to describe a command in a layer
 */
export interface LayerCommand {
  to: To[];
  description?: string;
}

type HyperKeySublayer = {
  // The ? is necessary, otherwise we'd have to define something for _every_ key code
  [key_code in KeyCode]?: LayerCommand;
};

export function quickCommandMap(key: KeyCode, command: string): KarabinerRule {
  return {
    description: `Shell command (Hyper + ${key})`,
    manipulators: [{
      type: 'basic',
      from: {
        key_code: key,
        modifiers: {
          mandatory: ["left_command", "left_control", "left_option", "left_shift"],
        }
      },
      to: [{ shell_command: command }],
    }]
  };
}

export function createHyperKey(options: {
  keyCode: KeyCode,
  modifiers?: Modifiers,
  restoreKeyFunction?: boolean
}): Manipulator {
  return {
    description: "Hyper Key",
    type: 'basic',
    from: {
      key_code: options.keyCode,
      modifiers: options.modifiers,
    },
    to: [
      {
        key_code: "left_shift",
        modifiers: ["left_command", "left_control", "left_option"],
      },
    ],
    to_if_alone: options.restoreKeyFunction ? [{
      key_code: options.keyCode,
    }] : undefined,
  };

}

/**
 * Create a Hyper Key sublayer, where every command is prefixed with a key
 * e.g. Hyper + O ("Open") is the "open applications" layer, I can press
 * e.g. Hyper + O + G ("Google Chrome") to open Chrome
 */
export function createHyperSubLayer(
  sublayer_key: KeyCode,
  commands: HyperKeySublayer,
  allSubLayerVariables: string[]
): Manipulator[] {
  const subLayerVariableName = generateSubLayerVariableName(sublayer_key);

  return [
    // When Hyper + sublayer_key is pressed, set the variable to 1; on key_up, set it to 0 again
    {
      description: `Toggle Hyper sublayer ${sublayer_key}`,
      type: "basic",
      from: {
        key_code: sublayer_key,
        modifiers: {
          mandatory: [
            "left_command",
            "left_control",
            "left_shift",
            "left_option",
          ],
        },
      },
      to_after_key_up: [
        {
          set_variable: {
            name: subLayerVariableName,
            // The default value of a variable is 0: https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/conditions/variable/
            // That means by using 0 and 1 we can filter for "0" in the conditions below and it'll work on startup
            value: 0,
          },
        },
      ],
      to: [
        {
          set_variable: {
            name: subLayerVariableName,
            value: 1,
          },
        },
      ],
      // This enables us to press other sublayer keys in the current sublayer
      // (e.g. Hyper + O > M even though Hyper + M is also a sublayer)
      // basically, only trigger a sublayer if no other sublayer is active
      conditions: allSubLayerVariables
        .filter((subLayerVariable) => subLayerVariable !== subLayerVariableName)
        .map((subLayerVariable) => ({
          type: "variable_if",
          name: subLayerVariable,
          value: 0,
        })),
    },
    // Define the individual commands that are meant to trigger in the sublayer
    ...(Object.keys(commands) as (keyof typeof commands)[]).map(
      (command_key): Manipulator => ({
        ...commands[command_key],
        type: "basic" as const,
        from: {
          key_code: command_key,
          modifiers: {
            // Mandatory modifiers are *not* added to the "to" event
            mandatory: ["any"],
          },
        },
        // Only trigger this command if the variable is 1 (i.e., if Hyper + sublayer is held)
        conditions: [
          {
            type: "variable_if",
            name: subLayerVariableName,
            value: 1,
          },
        ],
      })
    ),
  ];
}

export function withHyperKey(key: string, layerCommand: LayerCommand): KarabinerRule {
  const { description, to } = layerCommand;
  const finalDescription = description ? ` ${description}` : '';

  return {
    description: `HyperKey + ${key}${finalDescription}`,
    manipulators: [{
      type: 'basic' as const,
      from: {
        key_code: key as KeyCode,
        modifiers: { mandatory: HyperKeyModifiers },
      },
      to,
    }]
  };
};

/**
 * Create all hyper sublayers. This needs to be a single function, as well need to
 * have all the hyper variable names in order to filter them and make sure only one
 * activates at a time
 */
export function createHyperSubLayers(subLayers: {
  [key_code in KeyCode]?: HyperKeySublayer | LayerCommand;
}): KarabinerRule[] {
  const allSubLayerVariables = (
    Object.keys(subLayers) as (keyof typeof subLayers)[]
  ).map((sublayer_key) => generateSubLayerVariableName(sublayer_key));

  return Object.entries(subLayers).map(([key, value]) =>
    "to" in value
      ? {
        description: `Hyper Key + ${key}`,
        manipulators: [
          {
            ...value,
            type: "basic" as const,
            from: {
              key_code: key as KeyCode,
              modifiers: {
                // Mandatory modifiers are *not* added to the "to" event
                mandatory: [
                  "left_command",
                  "left_control",
                  "left_shift",
                  "left_option",
                ],
              },
            },
          },
        ],
      }
      : {
        description: `Hyper Key sublayer "${key}"`,
        manipulators: createHyperSubLayer(
          key as KeyCode,
          value,
          allSubLayerVariables
        ),
      }
  );
}

function generateSubLayerVariableName(key: KeyCode) {
  return `hyper_sublayer_${key}`;
}

/**
 * Shortcut for "open" shell command
 */
export function open(what: string): LayerCommand {
  return {
    to: [
      {
        shell_command: `open ${what}`,
      },
    ],
    description: `Open ${what}`,
  };
}

/**
 * Shortcut for "Open an app" command (of which there are a bunch)
 */
export function app(name: string): LayerCommand {
  return open(`-a '${name}.app'`);
}
