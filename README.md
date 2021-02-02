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
``CHR     POS     REF     U6164036        U8294222        U9052080``  
``aus0085 6458    G       G       T       T``  
``aus0085 6459    A       A       T       T``  
``aus0085 156753  C       C       T       T``  
``aus0085 183077  G       G       A       A``  
``aus0085 189748  T       G       G       G``  
``aus0085 206613  C       C       T       T``  
``aus0085 217723  C       C       A       A``  
``aus0085 232690  G       G       A       A``  
``aus0085 533743  T       G       C       C``  

* Note that position 533,743 has two alternative alleles (G and C).

### run Abuul-core
``sh Abuul-core.sh test.tab test_consequences.tab``  

``$ head test_consequences.tab ``  
``CHR     POS     REF     U6164036        U8294222        U9052080        NUMBER_OF_CONSEQUENCES  CONSEQUENCE``  
``aus0085 6458    G       G       T       T       1       [CONSEQUENCE:missense_variant c.251_252delGAinsTT p.Arg84Ile,aus0085_chr_p1-6.fna_00006]``  
``aus0085 6459    A       A       T       T       1       VARIANT_NOT_FOUND_IN_snps.csv``  
``aus0085 156753  C       C       T       T       1       [CONSEQUENCE:missense_variant c.1028G>A p.Ser343Asn,aus0085_chr_p1-6.fna_00162]``  
``aus0085 183077  G       G       A       A       1       [CONSEQUENCE:]``  
``aus0085 189748  T       G       G       G       1       [CONSEQUENCE:]``  
``aus0085 206613  C       C       T       T       1       [CONSEQUENCE:missense_variant c.860C>T p.Ala287Val,aus0085_chr_p1-6.fna_00205]``  
``aus0085 217723  C       C       A       A       1       [CONSEQUENCE:missense_variant c.859G>T p.Val287Phe,aus0085_chr_p1-6.fna_00217]``  
``aus0085 232690  G       G       A       A       1       [CONSEQUENCE:synonymous_variant c.720C>T p.Ile240Ile,aus0085_chr_p1-6.fna_00233]``  
``aus0085 533743  T       G       C       C       2       1:[synonymous_variant c.60T>C p.Cys20Cys,aus0085_chr_p1-6.fna_00513,,putative membrane protein]_2:[CONSEQUENCE:missense_variant c.60T>G p.Cys20Trp,aus0085_chr_p1-6.fna_00513,,putative membrane protein]``  

* Note that position 533,743 is reported with two consequences depending on the allele.


