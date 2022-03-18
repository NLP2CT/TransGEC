pip install subword-nmt

num_operations=8000
subword-nmt learn-bpe -s $num_operations < train_bea.tgt > /bp-molde/bpe_BEA-en.model
num_operations=30000
subword-nmt learn-bpe -s $num_operations < train_clang-en.tgt > /bp-molde/bpe_en.model
subword-nmt learn-bpe -s $num_operations < train_clang-de.tgt > /bp-molde/bpe_de.model
subword-nmt learn-bpe -s $num_operations < train_clang-ru.tgt > /bp-molde/bpe_ru.model


# --- take translationese as an example --- 
# Create four folders: base for GEC train data, trans for translationese synthetic data, native for native synthetic data, mix for mix synthetic data.
# Keep GEC:translationese = 1:1

cat /data/train_bea-en.src translationese.en.tok.error > /Bea19/trans/train.src
cat /data/train_bea-en.tgt translationese.en.tok.correct > /Bea19/trans/train.tgt

cat /data/train_clang-en.src translationese.en.tok.error > /English/trans/train.src
cat /data/train_clang-en.tgt translationese.en.tok.correct > /English/trans/train.tgt

cat /data/train_clang-en.src translationese.en.tok.error > /English/trans/train.src
cat /data/train_clang-en.tgt translationese.en.tok.correct > /English/trans/train.tgt

cat /data/train_clang-de.src translationese.de.tok.error > /German/trans/train.src
cat /data/train_clang-de.tgt translationese.de.tok.correct > /German/trans/train.tgt

cat /data/train_clang-ru.src translationese.de.tok.error > /Russian/train.src
cat /data/train_clang-ru.tgt translationese.ru.tok.correct > /Russian/train.tgt
 
# Note: chinese without bpe
cat base/train_clang-zh.src translationese.zh.tok.error > /Chinese/trans/train.src
cat base/train_clang-zh.tgt translationese.zh.tok.correct > /Chinese/trans/train.tgt


# ---- take cLang8-en as an example ----
# The Bea19-en, cLang8-de, cLang8-ru with the same way
 
for folder in base trans mix native 
do
 for tyle in dev test train
 do
   for tag in tgt src
   do
    
subword-nmt apply-bpe -c /bp-molde/bpe_en.model < /English/$folder/$tyle.$tag > /English/$folder/$tyle.bpe.$tag

   done 
 done 
done
