var scale_x = 13.5;
var scale_y = 13.5;

var center_x = 1920 / 2;
var center_y = 1080 / 2;

var offset_x = sprite_width * scale_x / 2;
var offset_y = sprite_height * scale_y / 2;

// Draw menu sprite with 60% transparency via draw_set_alpha
draw_set_alpha(0.6);
draw_sprite_ext(sprite_index, image_index, center_x - offset_x, center_y - offset_y, scale_x, scale_y, 0, c_white, 1);
draw_set_alpha(1);

// Draw text with border
draw_set_font(FNT_Main_XL);

var text = "Choose a Powerup!";
var text_x = center_x;
var text_y = 200;

draw_set_color(c_black);
for (var xo = -5; xo <= 5; xo += 5) {
    for (var yo = -5; yo <= 5; yo += 5) {
        if (xo != 0 || yo != 0) {
            draw_text(text_x + xo, text_y + yo, text);
        }
    }
}

draw_set_color(c_white);
draw_text(text_x, text_y, text);