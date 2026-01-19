data:extend({
    {
        type = "int-setting",
        name = "distance-factor",
        setting_type = "startup",
        default_value = 100,
        minimum_value = 1,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "brake-drag-enabled",
        setting_type = "startup",
        default_value = true,
        order = "e-a"
    },
    {
        type = "int-setting",
        name = "platform-max-speed",
        setting_type = "startup",
        default_value = 30000,
        minimum_value = 100,
        order = "b"
    },
    {
        type = "string-setting",
        name = "acceleration-formula",
        setting_type = "startup",
        allowed_values = {"relativistic","quadratic","linear"},
        default_value = "relativistic",
        order = "c"
    },
    {
        type = "int-setting",
        name = "weight-factor",
        setting_type = "startup",
        default_value = 5,
        minimum_value = 1,
        order = "d"
    },
    {
        type = "bool-setting",
        name = "modify-asteroid-definition",
        setting_type = "startup",
        default_value = false,
        order = "f"
    },
    {
        type = "bool-setting",
        name = "modify-asteroid-health",
        setting_type = "startup",
        default_value = true,
        order = "g-a"
    },
    {
        type = "bool-setting",
        name = "modify-asteroid-health-upto-medium",
        setting_type = "startup",
        default_value = true,
        order = "g-b"
    },
    {
        type = "int-setting",
        name = "asteroid-health-modification-percent",
        setting_type = "startup",
        default_value = 50,
        minimum_value = 1,
        order = "g-c"
    },
    {
        type = "int-setting",
        name = "spoil-update-tick-interval",
        setting_type = "startup",
        default_value = 300,
        minimum_value = 1,
        maximum_value = 18000,
        order = "i"
    },
    {
        type = "bool-setting",
        name = "modify-asteroid-mass",
        setting_type = "startup",
        default_value = true,
        order = "h-a"
    },
    {
        type = "int-setting",
        name = "asteroid-mass-modification-percent",
        setting_type = "startup",
        default_value = 50,
        minimum_value = 1,
        order = "h-b"
    },
    {
        type = "int-setting",
        name = "brake-drag-coefficient",
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0,
        order = "e-b"
    },
    {
        type = "int-setting",
        name = "brake_drag_speed_power",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 5,
        order = "e-c"
    }
})