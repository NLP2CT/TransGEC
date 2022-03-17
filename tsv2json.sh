#  --- TSV files ---
# take cLang-8 en as en example
paste cLang8-train.en.detok.src cLang8-train.en.detok.tgt > cLang8-train.en.detok.tsv
paste dev.detok.src dev.detok.tgt > dev.en.detok.tsv
paste test.detok.src test.detok.tgt > test.en.detok.tsv 
# if test set only have source file (eg. Bea19 test set) , you can
paste bea19_test.detok.src bea19_test.detok.src > bea19_test.detok.tsv

# base GEC data: TSV to JSON
python /script/tsv2json.py cLang8-train.en.detok.tsv cLang8-train.en.detok.json
python /script/tsv2json.py dev.en.detok.tsv dev.en.detok.json
python /script/tsv2json.py test.en.detok.tsv test.en.detok.json


# --- synthetic data with "tag" ---
# take English translationese as an example, other languages with the same way.

paste translationese.en.detok.src raslationese.en.detok.tgt > translationese.en.detok.tsv
python /script/tsv2json_tag.py translationese.en.detok.tsv translationese.en.detok.json  # if there may be some errors, please use the commend: "sed '/^\t/d' -i translationese.en.detok.tsv" first.

cat cLang8-train.en.detok.json translationese.en.detok.json | shuf > train_clang8-trans.en.json