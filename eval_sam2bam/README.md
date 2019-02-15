# eval_sam2bam

## sambamba view
```
sambamba 0.6.8 by Artem Tarasov and Pjotr Prins (C) 2012-2018
    LDC 1.10.0 / DMD v2.080.1 / LLVM6.0.1 / bootstrap LDC - the LLVM D compiler (0.17.4)

Usage: sambamba-view [options] <input.bam | input.sam> [region1 [...]]

Options: -F, --filter=FILTER
                    set custom filter for alignments
         --num-filter=NUMFILTER
                    filter flag bits; 'i1/i2' corresponds to -f i1 -F i2 samtools arguments;
                    either of the numbers can be omitted
         -f, --format=sam|bam|cram|json|unpack
                    specify which format to use for output (default is SAM);
                    unpack streams unpacked BAM
         -h, --with-header
                    print header before reads (always done for BAM output)
         -H, --header
                    output only header to stdout (if format=bam, the header is printed as SAM)
         -I, --reference-info
                    output to stdout only reference names and lengths in JSON
         -L, --regions=FILENAME
                    output only reads overlapping one of regions from the BED file
         -c, --count
                    output to stdout only count of matching records, hHI are ignored
         -v, --valid
                    output only valid alignments
         -S, --sam-input
                    specify that input is in SAM format
         -C, --cram-input
                    specify that input is in CRAM format
         -T, --ref-filename=FASTA
                    specify reference for writing CRAM
         -p, --show-progress
                    show progressbar in STDERR (works only for BAM files with no regions specified)
         -l, --compression-level
                    specify compression level (from 0 to 9, works only for BAM output)
         -o, --output-filename
                    specify output filename
         -t, --nthreads=NTHREADS
                    maximum number of threads to use
         -s, --subsample=FRACTION
                    subsample reads (read pairs)
         --subsampling-seed=SEED
                    set seed for subsampling
```

## samtools view
```
Usage: samtools view [options] <in.bam>|<in.sam>|<in.cram> [region ...]

Options:
  -b       output BAM
  -C       output CRAM (requires -T)
  -1       use fast BAM compression (implies -b)
  -u       uncompressed BAM output (implies -b)
  -h       include header in SAM output
  -H       print SAM header only (no alignments)
  -c       print only the count of matching records
  -o FILE  output file name [stdout]
  -U FILE  output reads not selected by filters to FILE [null]
  -t FILE  FILE listing reference names and lengths (see long help) [null]
  -L FILE  only include reads overlapping this BED FILE [null]
  -r STR   only include reads in read group STR [null]
  -R FILE  only include reads with read group listed in FILE [null]
  -q INT   only include reads with mapping quality >= INT [0]
  -l STR   only include reads in library STR [null]
  -m INT   only include reads with number of CIGAR operations consuming
           query sequence >= INT [0]
  -f INT   only include reads with all  of the FLAGs in INT present [0]
  -F INT   only include reads with none of the FLAGS in INT present [0]
  -G INT   only EXCLUDE reads with all  of the FLAGs in INT present [0]
  -s FLOAT subsample reads (given INT.FRAC option value, 0.FRAC is the
           fraction of templates/read pairs to keep; INT part sets seed)
  -M       use the multi-region iterator (increases the speed, removes
           duplicates and outputs the reads as they are ordered in the file)
  -x STR   read tag to strip (repeatable) [null]
  -B       collapse the backward CIGAR operation
  -?       print long help, including note about region specification
  -S       ignored (input format is auto-detected)
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
  -T, --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
```
