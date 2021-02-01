# Abuul-core
Provides SNP consequences for the core.tab file from snippy-core. Consequences are derived from the snps.csv files inside the snippy isolate folders. This script must be run in the snippy workspace dir

### get the code
``git clone https://github.com/abuultjens/Abuul-core.git``

### run the script
``sh Abuul-core.sh [core.tab] [core_with_consequences.tab]``

# Example

### run snippy
``snippy --outdir isolate_1 --ref ref.gbk --R1 isolate_1_R1.fq.gz --R2 isolate_1_R2.fq.gz``  
``snippy --outdir isolate_2 --ref ref.gbk --R1 isolate_2_R1.fq.gz --R2 isolate_2_R2.fq.gz``  
``snippy --outdir isolate_3 --ref ref.gbk --R1 isolate_3_R1.fq.gz --R2 isolate_3_R2.fq.gz``

### run snippy-core
``$ snippy-core --prefix test --ref ref.gbk isolate_1 isolate_2 isolate_3``  
``$ head test.tab``  
``CHR     POS     REF     2009-05176      2009-06134      2011-07041``  
``aus0085 6458    G       T       G       G``  
``aus0085 6459    A       T       A       A``  
``aus0085 156753  C       T       A       C``  
``aus0085 169362  G       G       T       G``  
``aus0085 183077  G       A       G       G``  
``aus0085 192469  C       A       C       C``  
``aus0085 206613  C       T       C       C``  
``aus0085 217723  C       A       C       C``  
``aus0085 228727  C       C       C       T``  

### run Abuul-core
``sh Abuul-core.sh test.tab test_consequences.tab``  
``$ head test_consequences.tab``  
``CHR     POS     REF     2009-05176      2009-06134      2011-07041      NUMBER_OF_CONSEQUENCES  CONSEQUENCE``  
``aus0085 6458    G       T       G       G       1       [CONSEQUENCE:missense_variant c.251_252delGAinsTT p.Arg84Ile,aus0085_chr_p1-6.fna_00006]``  
``aus0085 6459    A       T       A       A       1       VARIANT_NOT_FOUND_IN_snps.csv``  
``aus0085 156753  C       T       A       C       2       [CONSEQUENCE:missense_variant c.1028C>A p.Ser343Asn,aus0085_chr_p1-``6.fna_00162]_CONSEQUENCE:missense_variant c.1028C>T p.Ser343Asn,aus0085_chr_p1-6.fna_00162]``  
``aus0085 169362  G       G       T       G       1       [CONSEQUENCE:missense_variant c.305G>T p.Gly102Val,aus0085_chr_p1-6.fna_00174]``  
``aus0085 183077  G       A       G       G       1       [CONSEQUENCE:]``  
``aus0085 192469  C       A       C       C       1       [CONSEQUENCE:missense_variant c.2186C>A p.Pro729His,aus0085_chr_p1-6.fna_00193]``  
``aus0085 206613  C       T       C       C       1       [CONSEQUENCE:missense_variant c.860C>T p.Ala287Val,aus0085_chr_p1-6.fna_00205]``  
``aus0085 217723  C       A       C       C       1       [CONSEQUENCE:missense_variant c.859G>T p.Val287Phe,aus0085_chr_p1-6.fna_00217]``  
``ref 228727  C       C       C       T       1       [CONSEQUENCE:stop_gained c.443G>A p.Trp148*,aus0085_chr_p1-6.fna_00228]``  



