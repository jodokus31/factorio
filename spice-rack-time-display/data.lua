data:extend{{
    type = "font", 
    name = "spice_rack_gui_time_display_font", 
    from = "default-semibold", 
    size = 16,
}}

data.raw['gui-style'].default.spice_rack_gui_time_display_label =
{
    type = "label_style",
    parent = "label",
    font = "spice_rack_gui_time_display_font",
    left_padding = 6,
    right_padding = 6,
}