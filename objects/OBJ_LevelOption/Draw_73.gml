// Draw base button sprite bigger
draw_sprite_ext(sprite_index, image_index, x, y, 1.5, 1.5, 0, c_white, 1);

// Draw the power-up sprite based on power_type, also bigger
switch (power_type) {
    case PowerType.HP:
        //draw_sprite_ext(SPR_HP_Up, 0, x, y, 1.5, 1.5, 0, c_white, 1);
        break;

    case PowerType.ATK:
        draw_sprite_ext(SPR_ATK_Up, 0, x, y, 3, 3, 0, c_white, 1);
        break;

    case PowerType.SPD:
        //draw_sprite_ext(SPR_SPD_Up, 0, x, y, 1.5, 1.5, 0, c_white, 1);
        break;
}