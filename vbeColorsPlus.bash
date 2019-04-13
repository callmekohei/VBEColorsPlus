# ===========================================================================
#  FILE    : VBEColorsPlus.bash
#  AUTHOR  : callmekohei <callmekohei at gmail.com>
#  License : MIT license
# ===========================================================================

# see also: dimitropoulos/VBECustomColors https://github.com/dimitropoulos/VBECustomColors

function vs2012theme () {

  local fstSequence='ffffff00c0c0c0008080800000000000ff00000080000000ffff00008080000000ff00000080000000ffff00008080000000ff0000008000ff00ff0080008000'
  local sndSequence='00000000000080000080000000808000800000008000800080800000c0c0c000808080000000ff0000ff000000ffff00ff000000ff00ff00ffff0000ffffff00'
  local vbe7Default='ffffff00c0c0c0008080800000000000ff00000080000000ffff00008080000000ff00000080000000ffff00008080000000ff0000008000ff00ff0080008000'
  local vs2012theme='000000001e1e1e00343a40003c424800d4d4d400ffffff00264f7800569cd60074b0df00794e8b009f74b100e5140000d69d8500ce917800608b4e00b5cea800'

  # VBE7.DLLをテキストにする
  # HEXRAW format is 12
  certutil -f -encodehex $1 tmp.txt 12

  # 該当部分の文字列を置き換える
  # fstSeqの部分は1箇所、sndSeqの部分は39箇所ある
  # sndSeqは最初の部分のみ置き換える（sedは最初ののみ置き換えるので大丈夫）
  # see: Man sed ---> Sed Functions
  cat tmp.txt \
    | sed -e 's/'$fstSequence'/'$vs2012theme'/' \
          -e 's/'$sndSequence'/'$vs2012theme'/'\
    > tmp2.txt

  # テキストをバイナリにする
  certutil -f -decodehex tmp2.txt VBE7.DLL 12

  rm tmp.txt
  rm tmp2.txt

}

vs2012theme $1
