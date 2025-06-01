var scale = 4; // Sprite scale
var font_label = FNT_Main_Large;
var font_desc = FNT_Main_Big;

// Draw transparent base sprite
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, 0, c_white, 0);

// Pick power-up sprite and label
var label_text = "";
var desc_text_1 = "";
var desc_text_2 = "";

switch (power_type) {
    case PowerType.HP:
        draw_sprite_ext(SPR_HP_Up, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "MAX HP UP";
        desc_text_1 = "Increases your";
        desc_text_2 = "maximum health.";
        break;

    case PowerType.ATK:
        draw_sprite_ext(SPR_ATK_Up, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "ATTACK UP";
        desc_text_1 = "Boosts your";
        desc_text_2 = "damage output.";
        break;

    case PowerType.SPD:
        draw_sprite_ext(SPR_SPD_Up, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "SPEED UP";
        desc_text_1 = "Run and move";
        desc_text_2 = "faster.";
        break;

    case PowerType.SWORD:
        draw_sprite_ext(SPR_TreeATK, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "TREE SWORD";
        desc_text_1 = "Grants a swinging";
        desc_text_2 = "auto attack.";
        break;

    case PowerType.BOULDER:
        draw_sprite_ext(SPR_BoulderATK, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "BOULDER";
        desc_text_1 = "Drop boulders";
        desc_text_2 = "on enemies.";
        break;

    case PowerType.BOOMERANG:
        draw_sprite_ext(SPR_BananarangIcon, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "BANANARANG";
        desc_text_1 = "Throw a returning";
        desc_text_2 = "bananarang.";
        break;

    case PowerType.FLOAT:
        draw_sprite_ext(SPR_FloatingRockIcon, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "ROCK PARADE";
        desc_text_1 = "Rocks orbit and";
        desc_text_2 = "attack nearby foes.";
        break;

    case PowerType.DASH:
        draw_sprite_ext(SPR_Gorilla_Dash, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "DASH";
        desc_text_1 = "Dash through";
        desc_text_2 = "enemies quickly.";
        break;

    case PowerType.DART:
        draw_sprite_ext(SPR_DartMonkeyIcon, 0, x, y, scale, scale, 0, c_white, 1);
        label_text = "DART BURST";
        desc_text_1 = "Fire a spread";
        desc_text_2 = "of fast darts.";
        break;
}

// Text positions
draw_set_font(font_label);
var text_width = string_width(label_text);
var text_x = x - (text_width / 2);
var text_y = y + (sprite_get_height(SPR_HP_Up) * scale / 2) + 35;

draw_set_font(font_desc);
var desc_width_1 = string_width(desc_text_1);
var desc_width_2 = string_width(desc_text_2);
var desc_x1 = x - (desc_width_1 / 2);
var desc_x2 = x - (desc_width_2 / 2);
var desc_y1 = text_y + string_height(label_text) + 35;
var desc_y2 = desc_y1 + string_height(desc_text_1) + 4;

// Draw border (3px) for label and desc lines
var border = 3;
draw_set_color(c_black);

// label border
draw_set_font(font_label);
for (var dx = -border; dx <= border; dx += border) {
    for (var dy = -border; dy <= border; dy += border) {
        if (dx != 0 || dy != 0) draw_text(text_x + dx, text_y + dy, label_text);
    }
}

// desc line 1 border
draw_set_font(font_desc);
for (var dx = -border; dx <= border; dx += border) {
    for (var dy = -border; dy <= border; dy += border) {
        if (dx != 0 || dy != 0) draw_text(desc_x1 + dx, desc_y1 + dy, desc_text_1);
    }
}

// desc line 2 border
for (var dx = -border; dx <= border; dx += border) {
    for (var dy = -border; dy <= border; dy += border) {
        if (dx != 0 || dy != 0) draw_text(desc_x2 + dx, desc_y2 + dy, desc_text_2);
    }
}

// Draw main white text
draw_set_color(c_white);
draw_set_font(font_label);
draw_text(text_x, text_y, label_text);
draw_set_font(font_desc);
draw_text(desc_x1, desc_y1, desc_text_1);
draw_text(desc_x2, desc_y2, desc_text_2);
