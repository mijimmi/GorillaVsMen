var scale = 4; // Sprite scale
var font = FNT_Main_Large;

// Draw transparent base sprite
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, c_white, 0);

// Pick power-up sprite and label
var label_text = "";

switch (power_type) {
    case PowerType.HP:
        draw_sprite_ext(SPR_HP_Up, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "MAX HP UP";
        break;

    case PowerType.ATK:
        draw_sprite_ext(SPR_ATK_Up, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "ATTACK UP";
        break;

    case PowerType.SPD:
        draw_sprite_ext(SPR_SPD_Up, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "SPEED UP";
        break;

    case PowerType.SWORD:
        draw_sprite_ext(SPR_TreeATK, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "TREE SWORD";
        break;

    case PowerType.BOULDER:
        draw_sprite_ext(SPR_BoulderATK, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "BOULDER";
        break;
		
    case PowerType.BOOMERANG:
        draw_sprite_ext(SPR_BananarangIcon, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "BANANARANG";
        break;		
		
    case PowerType.FLOAT:
        draw_sprite_ext(SPR_FloatingRockIcon, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "ROCK PARADE";
        break;		
		
}

// Set font and compute text position
draw_set_font(font);
var text_width = string_width(label_text);
var text_x = x - (text_width / 2);
var text_y = y + (sprite_get_height(SPR_HP_Up) * scale / 2) + 25; // 

// Draw border (5px)
var border = 3;
draw_set_color(c_black);
draw_text(text_x - border, text_y, label_text);
draw_text(text_x + border, text_y, label_text);
draw_text(text_x, text_y - border, label_text);
draw_text(text_x, text_y + border, label_text);
draw_text(text_x - border, text_y - border, label_text);
draw_text(text_x + border, text_y - border, label_text);
draw_text(text_x - border, text_y + border, label_text);
draw_text(text_x + border, text_y + border, label_text);

// Draw main white text
draw_set_color(c_white);
draw_text(text_x, text_y, label_text);
