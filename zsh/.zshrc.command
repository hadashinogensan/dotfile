
alias vi='vim'
alias view='vim -R'
alias g="git"
alias pd='popd'
alias reload='source ~/.zshrc'

alias la='ls -A'
alias ll='ls -la'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

if [[ -x `whence -p ag` ]]; then
  alias grep='ag --hidden'
else
  alias grep='grep -n --color'
fi

alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'

# tmuxが起動していない場合にalias設定を行う
if [ $SHLVL = 1 ]; then
  alias tmux="tmux -2 attach || tmux -2 new-session \; source-file ~/dotfiles/tmux/.tmux.split"
fi

# =============================================================
# tail -f の拡張
# 例) tailf /path/to/logfile '検索文字列'
# =============================================================
function tailf() {
  if [ $# -eq 1 ]; then
    tail -f $1
  elif [ $# -eq 2 ]; then
    tail -f $1 | grep $2;
  fi
}

# =============================================================
# バックファイル作成関数
# 例) backup hoge.rb
#       -> hoge.rb.20150422 が作成される
# =============================================================
function backup() {
  if [ $# -lt 1 ];then
    echo '引数にファイル名を指定してください'
    return;
  fi
  _make_backup_file $1 0
}

function _make_backup_file() {

  if [ -e `_backup_filename $@` ]; then
    # カウントをインクリメントして、再帰的に呼び出す
    _make_backup_file $1 $(($2+1))
    return;
  fi

  # バックアップファイルを作成する
  echo " ${1} -> `_backup_filename ${@}`"
  if [ -f $1 ]; then
    cp $1 `_backup_filename ${@}`
  else
    cp -r $1 `_backup_filename ${@}`
  fi

}

function _backup_filename() {
  if [ $2 -gt 0 ]; then
    echo $1.`today`.$2
  else
    echo $1.`today`
  fi
}

function today(){
  echo $(date +%Y%m%d)
}

