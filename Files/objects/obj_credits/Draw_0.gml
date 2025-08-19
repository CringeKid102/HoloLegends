// obj_settings Draw Event
draw_set_font(fnt_main);
draw_set_halign(fa_center);

// Title
draw_set_color(c_white);
draw_text(menu_x, 50, global.language == 0 ? "Credits" : "クレジット");

draw_text(menu_x, 110, global.language == 0 ? "Programmer: William Ding" : "プログラマー: ウィリアム・ディン");
draw_text(menu_x, 150, global.language == 0 ? "Artist: William Ding" : "アーティスト: ウィリアム・ディン");
draw_text(menu_x, 190, global.language == 0 ? "Sound Design: William Ding" : "サウンドデザイン: ウィリアム・ディン");
draw_text(menu_x, 230, global.language == 0 ? "Special Thanks: Players & Testers" : "スペシャルサンクス: プレイヤー＆テスターの皆さん");

draw_btn(menu_x-50, menu_y, button_width, button_height, global.language == 0 ? "Exit" : "終了", mouse_x, mouse_y);

draw_set_color(c_white);