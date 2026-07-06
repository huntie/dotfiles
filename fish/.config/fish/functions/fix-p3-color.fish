# Convert P3-tagged JPEGs to sRGB so colours don't desaturate — needed because
# web uploads can strip or skip colour management, showing wide-gamut images
# (e.g. from Photomator/Pixelmator Pro) as washed out.

function fix-p3-color --description 'Convert JPEG(s) to sRGB colour profile for web'
    set -l p3_profile "/System/Library/ColorSync/Profiles/Display P3.icc"
    set -l srgb_profile "/System/Library/ColorSync/Profiles/sRGB Profile.icc"

    if test (count $argv) -eq 0
        echo "Usage: fix-p3-color <file.jpg> [file2.jpg ...]"
        return 1
    end

    for file in $argv
        if not test -f "$file"
            echo "Skipping $file: not found"
            continue
        end

        set -l has_profile (identify -format "%[profile:icc]" "$file" 2>/dev/null)

        if test -n "$has_profile"
            mogrify -profile "$srgb_profile" "$file"
        else
            mogrify -profile "$p3_profile" -profile "$srgb_profile" "$file"
        end

        echo "Converted $file"
    end
end
