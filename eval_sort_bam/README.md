# eval_sort_bam

## biobambam bamsort
```
This is biobambam version 0.0.191.
biobambam is distributed under version 3 of the GNU General Public License.

Key=Value pairs:

level=<[-1]>                  : compression settings for output bam file (-1=zlib default,0=uncompressed,1=fast,9=best)
SO=<[coordinate]>             : sorting order (coordinate or queryname)
verbose=<[1]>                 : print progress report
blockmb=<[1024]>              : size of internal memory buffer used for sorting in MiB
disablevalidation=<[0]>       : disable input validation (default is 0)
tmpfile=<filename>            : prefix for temporary files, default: create files in current directory
md5=<[0]>                     : create md5 check sum (default: 0)
md5filename=<filename>        : file name for md5 check sum
index=<[0]>                   : create BAM index (default: 0)
indexfilename=<filename>      : file name for BAM index file
inputformat=<[bam]>           : input format (bam,maussam,sam)
outputformat=<[bam]>          : output format (bam)
I=<[stdin]>                   : input filename (standard input if unset)
inputthreads=<[1]>            : input helper threads (for inputformat=bam only, default: 1)
reference=<>                  : reference FastA (.fai file required, for cram i/o only)
range=<>                      : coordinate range to be processed (for coordinate sorted indexed BAM input only)
outputthreads=<[1]>           : output helper threads (for outputformat=bam only, default: 1)
O=<[stdout]>                  : output filename (standard output if unset)
fixmates=<[0]>                : fix mate information (for name collated input only, disabled by default)
calmdnm=<[0]>                 : calculate MD and NM aux fields (for coordinate sorted output only)
calmdnmreference=<[]>         : reference for calculating MD and NM aux fields (calmdnm=1 only)
calmdnmrecompindetonly=<[0]>  : only recalculate MD and NM in the presence of indeterminate bases (calmdnm=1 only)
calmdnmwarnchange=<[0]>       : warn when changing existing MD/NM fields (calmdnm=1 only)
adddupmarksupport=<[0]>       : add info for streaming duplicate marking (for name collated input only, ignored for fixmate=0, disabled by default)
tag=<[a-zA-Z][a-zA-Z0-9]>     : aux field id for tag string extraction (adddupmarksupport=1 only)
nucltag=<[a-zA-Z][a-zA-Z0-9]> : aux field id for nucleotide tag extraction (adddupmarksupport=1 only)
markduplicates=<[0]>          : mark duplicates (only when input name collated and output coordinate sorted, disabled by default)
```

## picard SortSam
```
USAGE: SortSam [options]

Documentation: http://broadinstitute.github.io/picard/command-line-overview.html#SortSam

This tool sorts the input SAM or BAM file by coordinate, queryname (QNAME), or some other property of the SAM record.
The SortOrder of a SAM/BAM file is found in the SAM file header tag @HD in the field labeled SO.  
For a coordinate sorted SAM/BAM file, read alignments are sorted first by the reference sequence name (RNAME) field
using the reference sequence dictionary (@SQ tag).  Alignments within these subgroups are secondarily sorted using the
left-most mapping position of the read (POS).  Subsequent to this sorting scheme, alignments are listed arbitrarily.

For queryname-sorted alignments, all alignments are grouped using the queryname field but the alignments are not
necessarily sorted within these groups.  Reads having the same queryname are derived from the same template.



Usage example:

java -jar picard.jar SortSam \
I=input.bam \
O=sorted.bam \
SORT_ORDER=coordinate

Version: 2.18.24-SNAPSHOT


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

INPUT=File
I=File                        Input BAM or SAM file to sort.  Required. 

OUTPUT=File
O=File                        Sorted BAM or SAM output file.  Required. 

SORT_ORDER=SortOrder
SO=SortOrder                  Sort order of output file.   Required. Possible values: {
                              queryname (Sorts according to the readname. This will place read-pairs and other derived
                              reads (secondary and supplementary) adjacent to each other. Note that the readnames are
                              compared lexicographically, even though they may include numbers. In paired reads, Read1
                              sorts before Read2.)
                              coordinate (Sorts primarily according to the SEQ and POS fields of the record. The
                              sequence will sorted according to the order in the sequence dictionary, taken from from
                              the header of the file. Within each reference sequence, the reads are sorted by the
                              position. Unmapped reads whose mates are mapped will be placed near their mates. Unmapped
                              read-pairs are placed after all the mapped reads and their mates.)
                              duplicate (Sorts the reads so that duplicates reads are adjacent. Required that the
                              mate-cigar (MC) tag is present. The resulting will be sorted by library, unclipped 5-prime
                              position, orientation, and mate's unclipped 5-prime position.)
                              } 
```

## sambamba sort
```
sambamba 0.6.8 by Artem Tarasov and Pjotr Prins (C) 2012-2018
    LDC 1.10.0 / DMD v2.080.1 / LLVM6.0.1 / bootstrap LDC - the LLVM D compiler (0.17.4)

Usage: sambamba-sort [options] <input.bam>

Options: -m, --memory-limit=LIMIT
               approximate total memory limit for all threads (by default 2GB)
         --tmpdir=TMPDIR
               directory for storing intermediate files; default is system directory for temporary files
         -o, --out=OUTPUTFILE
               output file name; if not provided, the result is written to a file with .sorted.bam extension
         -n, --sort-by-name
               sort by read name instead of coordinate (lexicographical order)
         -N, --natural-sort
               sort by read name instead of coordinate (so-called 'natural' sort as in samtools)
         -l, --compression-level=COMPRESSION_LEVEL
               level of compression for sorted BAM, from 0 to 9
         -u, --uncompressed-chunks
               write sorted chunks as uncompressed BAM (default is writing with compression level 1), that might be faster in some cases but uses more disk space
         -p, --show-progress
               show progressbar in STDERR
         -t, --nthreads=NTHREADS
               use specified number of threads
         -F, --filter=FILTER
               keep only reads that satisfy FILTER
```

## samtools sort
```
Usage: samtools sort [options...] [in.bam]
Options:
  -l INT     Set compression level, from 0 (uncompressed) to 9 (best)
  -m INT     Set maximum memory per thread; suffix K/M/G recognized [768M]
  -n         Sort by read name
  -t TAG     Sort by value of TAG. Uses position as secondary index (or read name if -n is set)
  -o FILE    Write final output to FILE rather than standard output
  -T PREFIX  Write temporary files to PREFIX.nnnn.bam
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
```
