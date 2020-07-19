PARSE=../parse-medici-torino/parse.py
TOGEOJSON=../parse-medici-torino/json2geojson.py

PDFS="Medici-di-Medicina-Generale-Circoscrizione-1.pdf
Medici-di-Medicina-Generale-Circoscrizione-2.pdf
Medici-di-Medicina-Generale-Circoscrizione-3.pdf
Medici-di-Medicina-Generale-Circoscrizione-4-1.pdf
Medici-di-Medicina-Generale-Circoscrizione-5.pdf
Medici-di-Medicina-Generale-Circoscrizione-6.pdf
Medici-di-Medicina-Generale-Circoscrizione-7.pdf
Medici-di-Medicina-Generale-Circoscrizione-8.pdf"

JSONS=""

for pdf in $PDFS; do
	curl http://www.aslcittaditorino.it/wp-content/uploads/2020/06/$pdf > $pdf
	filename=$(basename -s.pdf $pdf)
	pdftotext $pdf $filename.txt
	cat $filename.txt | python3 $PARSE > $filename.json 2> $filename.log
	JSONS="$JSONS $filename.json"
done

python3 $TOGEOJSON $JSONS > medici.geojson
