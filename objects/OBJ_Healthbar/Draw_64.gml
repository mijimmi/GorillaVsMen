// Draw background stretched to match new size
draw_sprite_stretched(SPR_HealthBG, 0, healthbar_x, healthbar_y, healthbar_width, healthbar_height);

// Draw health fill scaled by HP ratio
if (instance_exists(OBJ_Gorilla)) {
    var g = instance_find(OBJ_Gorilla, 0);
    var hp_ratio = clamp(g.hp / g.hp_max, 0, 1);
    draw_sprite_stretched(SPR_Health, 0, healthbar_x, healthbar_y, hp_ratio * healthbar_width, healthbar_height);

    // Set text color and alignment
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Draw HP text centered in the healthbar
    var text = string(g.hp) + " / " + string(g.hp_max);
    draw_text(healthbar_x + healthbar_width / 2, healthbar_y + healthbar_height / 2, text);
}

// Draw border stretched to match new size
draw_sprite_stretched(SPR_HealthBorder, 0, healthbar_x, healthbar_y, healthbar_width, healthbar_height);