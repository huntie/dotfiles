# A general, all-purpose extraction function.
# Inspired by https://bit.ly/2CD8IO6

function extract --description 'Extract an archive into a new directory'
    set -l archive $argv[1]

    if [ -z $archive ]
        printf "Give archive to extract as argument.\\n"
    end

    set -l outdir (string replace -r '\\.+[^/]+$' '' $archive)

    if [ -f $archive ]
        switch $archive
            case *.zip
            case *.ipa
                unzip $archive -d $outdir
            case *.tar.gz
                tar xf $archive -C $outdir
            case '*'
                printf "extract: '%s' - unknown archive method\\n" $archive
        end
    else
        printf "File \"%s\" not found.\\n" $archive
    end
end
