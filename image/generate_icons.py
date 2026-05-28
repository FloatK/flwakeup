from PIL import Image
import os
import struct
import io

# 路径配置
BASE_DIR = r'E:\flproject\flass'
IMG1_PATH = os.path.join(BASE_DIR, 'image', 'img1.png')  # 前景
IMG2_PATH = os.path.join(BASE_DIR, 'image', 'img2.png')  # 背景（仅用于分层图标）

# Android Adaptive Icon 尺寸（108dp）
ANDROID_ADAPTIVE_SIZES = {
    'mdpi': 108,
    'hdpi': 162,
    'xhdpi': 216,
    'xxhdpi': 324,
    'xxxhdpi': 432,
}

# iOS 图标尺寸
IOS_SIZES = [
    ('Icon-App-20x20@1x.png', 20),
    ('Icon-App-20x20@2x.png', 40),
    ('Icon-App-20x20@3x.png', 60),
    ('Icon-App-29x29@1x.png', 29),
    ('Icon-App-29x29@2x.png', 58),
    ('Icon-App-29x29@3x.png', 87),
    ('Icon-App-40x40@1x.png', 40),
    ('Icon-App-40x40@2x.png', 80),
    ('Icon-App-40x40@3x.png', 120),
    ('Icon-App-60x60@2x.png', 120),
    ('Icon-App-60x60@3x.png', 180),
    ('Icon-App-76x76@1x.png', 76),
    ('Icon-App-76x76@2x.png', 152),
    ('Icon-App-83.5x83.5@2x.png', 167),
    ('Icon-App-1024x1024@1x.png', 1024),
]

# macOS 图标尺寸
MACOS_SIZES = [
    ('app_icon_16.png', 16),
    ('app_icon_32.png', 32),
    ('app_icon_64.png', 64),
    ('app_icon_128.png', 128),
    ('app_icon_256.png', 256),
    ('app_icon_512.png', 512),
    ('app_icon_1024.png', 1024),
]

# Web 图标尺寸
WEB_SIZES = [
    ('Icon-192.png', 192),
    ('Icon-512.png', 512),
    ('Icon-maskable-192.png', 192),
    ('Icon-maskable-512.png', 512),
]

# Windows ICO 尺寸
WINDOWS_ICO_SIZES = [16, 24, 32, 48, 64, 128, 256]


def resize_icon(image_path, size):
    """调整图片到指定尺寸（保持比例，留边距）"""
    img = Image.open(image_path).convert('RGBA')
    margin = int(size * 0.1)
    max_size = size - 2 * margin
    
    ratio = min(max_size / img.width, max_size / img.height)
    new_w = int(img.width * ratio)
    new_h = int(img.height * ratio)
    img = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
    
    result = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    x = (size - new_w) // 2
    y = (size - new_h) // 2
    result.paste(img, (x, y), img)
    
    return result


def create_adaptive_foreground(image_path, size):
    """创建 Android Adaptive Icon 前景（安全区域 66dp/108dp）"""
    img = Image.open(image_path).convert('RGBA')
    
    safe_ratio = 0.61
    safe_size = int(size * safe_ratio)
    
    ratio = min(safe_size / img.width, safe_size / img.height)
    new_w = int(img.width * ratio)
    new_h = int(img.height * ratio)
    img = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
    
    result = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    x = (size - new_w) // 2
    y = (size - new_h) // 2
    result.paste(img, (x, y), img)
    
    return result


def create_adaptive_background(image_path, size):
    """创建 Android Adaptive Icon 背景"""
    bg = Image.open(image_path).convert('RGBA')
    bg = bg.resize((size, size), Image.Resampling.LANCZOS)
    return bg


def save_as_ico(images, output_path):
    """保存为 ICO 文件"""
    ico_data = []
    for img in images:
        if img.mode != 'RGBA':
            img = img.convert('RGBA')
        png_buffer = io.BytesIO()
        img.save(png_buffer, 'PNG')
        png_data = png_buffer.getvalue()
        ico_data.append((img.width, img.height, png_data))
    
    with open(output_path, 'wb') as f:
        f.write(struct.pack('<HHH', 0, 1, len(ico_data)))
        data_offset = 6 + 16 * len(ico_data)
        for width, height, png_data in ico_data:
            w = width if width < 256 else 0
            h = height if height < 256 else 0
            f.write(struct.pack('<BBBBHHII', w, h, 0, 0, 1, 32, len(png_data), data_offset))
            data_offset += len(png_data)
        for _, _, png_data in ico_data:
            f.write(png_data)


def create_fused_icon(foreground_path, background_path, size):
    """合成前景和背景"""
    fg = Image.open(foreground_path).convert('RGBA')
    bg = Image.open(background_path).convert('RGBA')
    
    bg = bg.resize((size, size), Image.Resampling.LANCZOS)
    
    margin = int(size * 0.1)
    max_size = size - 2 * margin
    
    ratio = min(max_size / fg.width, max_size / fg.height)
    new_w = int(fg.width * ratio)
    new_h = int(fg.height * ratio)
    fg = fg.resize((new_w, new_h), Image.Resampling.LANCZOS)
    
    x = (size - new_w) // 2
    y = (size - new_h) // 2
    
    result = bg.copy()
    result.paste(fg, (x, y), fg)
    
    return result


def main():
    print("开始生成全平台 App 图标...")
    
    # ==================== Android (Adaptive Icon: 前景=img1, 背景=img2) ====================
    print("\n[Android] 生成 Adaptive Icon:")
    
    anydpi_dir = os.path.join(BASE_DIR, 'android', 'app', 'src', 'main', 'res', 'mipmap-anydpi-v26')
    os.makedirs(anydpi_dir, exist_ok=True)
    
    xml_path = os.path.join(anydpi_dir, 'ic_launcher.xml')
    with open(xml_path, 'w', encoding='utf-8') as f:
        f.write('''<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@mipmap/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
''')
    print(f"  [OK] mipmap-anydpi-v26/ic_launcher.xml")
    
    for density, size in ANDROID_ADAPTIVE_SIZES.items():
        output_dir = os.path.join(BASE_DIR, 'android', 'app', 'src', 'main', 'res', f'mipmap-{density}')
        os.makedirs(output_dir, exist_ok=True)
        
        old_icon = os.path.join(output_dir, 'ic_launcher.png')
        if os.path.exists(old_icon):
            os.remove(old_icon)
        
        fg_path = os.path.join(output_dir, 'ic_launcher_foreground.png')
        create_adaptive_foreground(IMG1_PATH, size).save(fg_path, 'PNG')
        
        bg_path = os.path.join(output_dir, 'ic_launcher_background.png')
        create_adaptive_background(IMG2_PATH, size).save(bg_path, 'PNG')
        
        print(f"  [OK] {density}: {size}x{size}")
    
    # ==================== iOS (iOS 18+ 外观变体) ====================
    print("\n[iOS] 生成图标 (iOS 18+ 外观变体):")
    ios_dir = os.path.join(BASE_DIR, 'ios', 'Runner', 'Assets.xcassets', 'AppIcon.appiconset')
    
    # Default (Light): img1 + img2 融合
    default_icon = create_fused_icon(IMG1_PATH, IMG2_PATH, 1024)
    default_icon.save(os.path.join(ios_dir, 'Icon-App-1024x1024@1x.png'), 'PNG')
    print("  [OK] Default (Light): 1024x1024")
    
    # Dark: img1 透明背景
    dark_icon = resize_icon(IMG1_PATH, 1024)
    dark_icon.save(os.path.join(ios_dir, 'Icon-App-Dark-1024x1024@1x.png'), 'PNG')
    print("  [OK] Dark: 1024x1024")
    
    # Tinted: img1 灰度版本
    tinted_icon = resize_icon(IMG1_PATH, 1024).convert('L').convert('RGBA')
    tinted_icon.save(os.path.join(ios_dir, 'Icon-App-Tinted-1024x1024@1x.png'), 'PNG')
    print("  [OK] Tinted (grayscale): 1024x1024")
    
    # 生成其他尺寸（用于旧版 iOS）
    for filename, size in IOS_SIZES:
        if size != 1024:
            output_path = os.path.join(ios_dir, filename)
            resize_icon(IMG1_PATH, size).save(output_path, 'PNG')
            print(f"  [OK] {filename}: {size}x{size}")
    
    # 更新 Contents.json
    import json
    contents = {
        "info": {
            "author": "xcode",
            "version": 1
        },
        "images": [
            # iPhone
            {"size": "20x20", "idiom": "iphone", "filename": "Icon-App-20x20@2x.png", "scale": "2x"},
            {"size": "20x20", "idiom": "iphone", "filename": "Icon-App-20x20@3x.png", "scale": "3x"},
            {"size": "29x29", "idiom": "iphone", "filename": "Icon-App-29x29@1x.png", "scale": "1x"},
            {"size": "29x29", "idiom": "iphone", "filename": "Icon-App-29x29@2x.png", "scale": "2x"},
            {"size": "29x29", "idiom": "iphone", "filename": "Icon-App-29x29@3x.png", "scale": "3x"},
            {"size": "40x40", "idiom": "iphone", "filename": "Icon-App-40x40@2x.png", "scale": "2x"},
            {"size": "40x40", "idiom": "iphone", "filename": "Icon-App-40x40@3x.png", "scale": "3x"},
            {"size": "60x60", "idiom": "iphone", "filename": "Icon-App-60x60@2x.png", "scale": "2x"},
            {"size": "60x60", "idiom": "iphone", "filename": "Icon-App-60x60@3x.png", "scale": "3x"},
            # iPad
            {"size": "20x20", "idiom": "ipad", "filename": "Icon-App-20x20@1x.png", "scale": "1x"},
            {"size": "20x20", "idiom": "ipad", "filename": "Icon-App-20x20@2x.png", "scale": "2x"},
            {"size": "29x29", "idiom": "ipad", "filename": "Icon-App-29x29@1x.png", "scale": "1x"},
            {"size": "29x29", "idiom": "ipad", "filename": "Icon-App-29x29@2x.png", "scale": "2x"},
            {"size": "40x40", "idiom": "ipad", "filename": "Icon-App-40x40@1x.png", "scale": "1x"},
            {"size": "40x40", "idiom": "ipad", "filename": "Icon-App-40x40@2x.png", "scale": "2x"},
            {"size": "76x76", "idiom": "ipad", "filename": "Icon-App-76x76@1x.png", "scale": "1x"},
            {"size": "76x76", "idiom": "ipad", "filename": "Icon-App-76x76@2x.png", "scale": "2x"},
            {"size": "83.5x83.5", "idiom": "ipad", "filename": "Icon-App-83.5x83.5@2x.png", "scale": "2x"},
            # Marketing (Default)
            {"filename": "Icon-App-1024x1024@1x.png", "idiom": "ios-marketing", "platform": "ios", "size": "1024x1024", "scale": "1x"},
            # Dark
            {"appearances": [{"appearance": "luminosity", "value": "dark"}], "filename": "Icon-App-Dark-1024x1024@1x.png", "idiom": "ios-marketing", "platform": "ios", "size": "1024x1024", "scale": "1x"},
            # Tinted
            {"appearances": [{"appearance": "luminosity", "value": "tinted"}], "filename": "Icon-App-Tinted-1024x1024@1x.png", "idiom": "ios-marketing", "platform": "ios", "size": "1024x1024", "scale": "1x"}
        ]
    }
    
    with open(os.path.join(ios_dir, 'Contents.json'), 'w') as f:
        json.dump(contents, f, indent=2)
    print("  [OK] Contents.json (iOS 18+)")
    
    # ==================== macOS (只用 img1) ====================
    print("\n[macOS] 生成图标:")
    macos_dir = os.path.join(BASE_DIR, 'macos', 'Runner', 'Assets.xcassets', 'AppIcon.appiconset')
    for filename, size in MACOS_SIZES:
        output_path = os.path.join(macos_dir, filename)
        resize_icon(IMG1_PATH, size).save(output_path, 'PNG')
        print(f"  [OK] {filename}: {size}x{size}")
    
    # ==================== Web (只用 img1) ====================
    print("\n[Web] 生成图标:")
    web_dir = os.path.join(BASE_DIR, 'web', 'icons')
    for filename, size in WEB_SIZES:
        output_path = os.path.join(web_dir, filename)
        resize_icon(IMG1_PATH, size).save(output_path, 'PNG')
        print(f"  [OK] {filename}: {size}x{size}")
    
    # ==================== Windows (只用 img1) ====================
    print("\n[Windows] 生成图标:")
    ico_path = os.path.join(BASE_DIR, 'windows', 'runner', 'resources', 'app_icon.ico')
    ico_images = [resize_icon(IMG1_PATH, s) for s in WINDOWS_ICO_SIZES]
    save_as_ico(ico_images, ico_path)
    print(f"  [OK] app_icon.ico: {WINDOWS_ICO_SIZES}")
    
    # ==================== Linux (只用 img1) ====================
    print("\n[Linux] 生成图标:")
    linux_icon_path = os.path.join(BASE_DIR, 'linux', 'icon.png')
    resize_icon(IMG1_PATH, 256).save(linux_icon_path, 'PNG')
    print(f"  [OK] icon.png: 256x256")
    
    print("\n[OK] 全平台图标生成完成！")


if __name__ == '__main__':
    main()
