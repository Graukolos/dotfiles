#! /bin/sh

case "$@" in
    "$@")
        QUICK_INSTALL="$@"
        ;;
    ""|*)
        QUICK_INSTALL="n"
        ;;
esac

prompt () {
    printf "%s" "Do you want to $1 $2 (y/n)"
    read ans
}

install () {
    [[ -n $(pacman -Qq | grep "$1") ]] && \

ans=""
  if [[ $ans == "y"  ]]; then
    if command -v paru 2> /dev/null; then
      command -v paru || \
      command -v git && \
          git clone --depth=1 https://aur.archlinux.org/paru-bin && \
          cd paru && \
          makepkg -si && \
          cd "$(pwd)/.." && \
          rm -rf paru;
    fi
    if paru -S $1; then
    	break
    fi
  fi
}

for config in $(ls -1A)
do
    [[ $config = '^.+\.[A-Za-z]+$|.git' || $config = "LICENSE" ]] && \
        continue || \
        ans="" && \
    [ "$QUICK_INSTALL" != "y" ] && prompt copy $config || ans="y"

    [ "$ans" = "y" ] && \
        DESTINATION=""
        case $config in
            .vimrc|.zshrc|.azotebg|wallpapers|material)
                DESTINATION="$HOME"
                ;;
            greetd)
                DESTINATION=""
                sudo cp -rf "$config" "/etc/"
                ;;
            startpage|chrome)
                DESTINATION='~/.mozilla/firefox/*.default-release/'
                ;;
            *)
                DESTINATION="$HOME/.config"
                ;;
        esac
        [ -n $DESTINATION ] && [ -d $DESTINATION ] && \
            cp -rf "$config" "$DESTINATION" || \
            cp "$config" "$DESTINATION";

        install config;
done

printf "%s\n" "Optional but recommended"

while read -r line
do
    if ! install $line
    then
        continue
    fi
done <<-EOF
azote
qt5ct
grim
slurp
swappy
wf-recorder
brightnessctl
otf-font-awesome
autotiling
wofer-git
rivertiler-git
greetd
nerd-fonts-cascadia-code
EOF

printf "%s\n" "Installation finished! :poggersphisch:"
