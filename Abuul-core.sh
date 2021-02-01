#!/bin/bash

INFILE=test.tab
OUTFILE=out.tab

# generate random prefix for all tmp files
RAND_1=`echo $((1 + RANDOM % 100))`
RAND_2=`echo $((100 + RANDOM % 200))`
RAND_3=`echo $((200 + RANDOM % 300))`
RAND=`echo "${RAND_1}${RAND_2}${RAND_3}"`

# make ele_pos index from snps.tab file
tail -n +2 ${INFILE} | cut -f 1-2 | tr '\t' '_' > ${RAND}_INDEX.txt

# make list of isolates in snps.tab file
head -1 ${INFILE} | cut -f 4- | tr '\t' '\n' > ${RAND}_isolates_list.txt

# make db from snps.tab from each isolate folder
for ISOLATE in $(cat ${RAND}_isolates_list.txt); do
	tail -n +2 ${ISOLATE}/snps.csv | cut -f 1-2 -d ',' | tr ',' '_' >> ${RAND}_index_tmp.txt
	tail -n +2 ${ISOLATE}/snps.csv | cut -f 3- -d ',' >> ${RAND}_db_tmp.txt
done
paste ${RAND}_index_tmp.txt ${RAND}_db_tmp.txt | tr '\t' ',' > ${RAND}_DB.txt

# write header to CONSEQUENCE file
echo "NUMBER_OF_CONSEQUENCES	CONSEQUENCE" > ${RAND}_CONSEQUENCE.txt

for INDEX in $(cat ${RAND}_INDEX.txt); do
	if grep "${INDEX}" ${RAND}_DB.txt 1> /dev/null 2>&1; then
		WC=`grep "${INDEX}" ${RAND}_DB.txt | cut -f 10 -d ',' | sort | uniq | wc -l`
                if [ "${WC}" == "1" ]; then
			CONSEQUENCE_TMP=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | cut -f 10 -d ','`
			ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | tail -1 | cut -f 4 -d ','`
			CONSEQUENCE=[ALLELE:${ALLELE}_CONSEQUENCE:${CONSEQUENCE_TMP}]
                fi 
		if [ "${WC}" == "2" ]; then
			FIRST_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | tail -1 | cut -f 4 -d ','`
			FIRST_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | tail -1 | cut -f 10 -d ','`
			SECOND_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -2 | tail -1 | cut -f 4 -d ','`
			SECOND_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -2 | tail -1 | cut -f 10 -d ','`
			CONSEQUENCE=[ALLELE:${FIRST_ALLELE}_CONSEQUENCE:${FIRST_CONSEQUENCE}]_[ALLELE:${SECOND_ALLELE}_CONSEQUENCE:${SECOND_CONSEQUENCE}]
		fi
		if [ "${WC}" == "3" ]; then
                        FIRST_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | tail -1 | cut -f 4 -d ','`
                        FIRST_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | tail -1 | cut -f 10 -d ','`
                        SECOND_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -2 | tail -1 | cut -f 4 -d ','`
                        SECOND_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -2 | tail -1 | cut -f 10 -d ','`
                        THIRD_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -3 | tail -1 | cut -f 4 -d ','`
                        THIRD_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -3 | tail -1 | cut -f 10 -d ','`
			CONSEQUENCE=[ALLELE:${FIRST_ALLELE}_CONSEQUENCE:${FIRST_CONSEQUENCE}]_ALLELE:${SECOND_ALLELE}_CONSEQUENCE:${SECOND_CONSEQUENCE}_ALLELE:${THIRD_ALLELE}_CONSEQUENCE:${THIRD_CONSEQUENCE}]
		fi
                if [ "${WC}" == "4" ]; then
                        FIRST_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | tail -1 | cut -f 4 -d ','`
                        FIRST_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -1 | tail -1 | cut -f 10 -d ','`
                        SECOND_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -2 | tail -1 | cut -f 4 -d ','`
                        SECOND_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -2 | tail -1 | cut -f 10 -d ','`
                        THIRD_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -3 | tail -1 | cut -f 4 -d ','`
                        THIRD_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -3 | tail -1 | cut -f 10 -d ','`
			FOURTH_ALLELE=`grep "${INDEX}" ${RAND}_DB.txt | head -4 | tail -1 | cut -f 4 -d ','`
                        FOURTH_CONSEQUENCE=`grep "${INDEX}" ${RAND}_DB.txt | head -4 | tail -1 | cut -f 10 -d ','`
			CONSEQUENCE=[ALLELE:${FIRST_ALLELE}_CONSEQUENCE:${FIRST_CONSEQUENCE}]_ALLELE:${SECOND_ALLELE}_CONSEQUENCE:${SECOND_CONSEQUENCE}_ALLELE:${THIRD_ALLELE}_CONSEQUENCE:${THIRD_CONSEQUENCE}_ALLELE:${FOURTH_ALLELE}_CONSEQUENCE:${FOURTH_CONSEQUENCE}]
                fi

	else
		CONSEQUENCE=VARIANT_NOT_FOUND_IN_snps.csv
	fi
	echo "${WC}	${CONSEQUENCE}" >> ${RAND}_CONSEQUENCE.txt
done

paste ${INFILE} ${RAND}_CONSEQUENCE.txt > ${OUTFILE}

rm ${RAND}_*


