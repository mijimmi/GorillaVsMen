// --- Draw GUI Event (OBJ_Healthbar) ---
if (!instance_exists(OBJ_Gorilla)) exit;
var gor = instance_find(OBJ_Gorilla, 0);

// 1) World → GUI conversion (unchanged)
var cam = view_camera[0];
var vx  = camera_get_view_x(cam),   vy  = camera_get_view_y(cam);
var vw  = camera_get_view_width(cam), vh  = camera_get_view_height(cam);
var gw  = display_get_gui_width(),   gh  = display_get_gui_height();
var sx  = gw / vw,                   sy  = gh / vh;
var gx  = (gor.x - vx) * sx,         gy  = (gor.y - vy) * sy;

// 2) New, smaller health‑bar size & offset
var bar_w    = 160;  // was 320
var bar_h    = 24;   // was 48
var padding  = 4;    // half the original padding
var bx       = gx - bar_w * 0.5;
var by       = gy + padding;

// 3) Draw background
draw_sprite_stretched(SPR_HealthBG, 0, bx, by, bar_w, bar_h);

// 4) Draw fill
var hp_ratio = clamp(gor.hp / gor.hp_max, 0, 1);
draw_sprite_stretched(SPR_Health, 0, bx, by, hp_ratio * bar_w, bar_h);

// 5) Draw text
draw_set_font(FNT_Main);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(bx + bar_w * 0.5, by + bar_h * 0.5,
          string(gor.hp) + " / " + string(gor.hp_max));

// 6) Draw border
draw_sprite_stretched(SPR_HealthBorder, 0, bx, by, bar_w, bar_h);