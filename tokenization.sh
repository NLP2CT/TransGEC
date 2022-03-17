# --- En/De/Ru ---
# you can sample 1:1 for GEC train data and translationese/native texts, remember keep the tokens within 70.

python /script/tokenization/sptok_en.py translationesep.en.txt translationese.en.tok.txt 
python /script/tokenization/sptok_de.py translationese.de.txt translationese.de.tok.txt 
python /script/tokenization/sptok_ru.py translationese.ru.txt translationese.ru.tok.txt 

python /script/tokenization/sptok_en.py native.en.txt native.en.tok.txt 
python /script/tokenization/sptok_de.py native.de.txt native.de.tok.txt 
python /script/tokenization/sptok_ru.py native.ru.txt native.ru.tok.txt 

# Zh
python /script/tokenization/chartok_zh.py translationese.zh.txt translationese.zh.tok.txt
python /script/tokenization/chartok_zh.py native.zh.txt native.zh.tok.txt 