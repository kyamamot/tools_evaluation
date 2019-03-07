## eval_combination_01
samtoolsとSambambaとbiobambamの比較
- CPUスレッド数は全て8
- BAMは全フェーズにおいて非圧縮

## eval_combination_02
BAM圧縮あり/なしの違い
- 上記eval_combination_01との比較
- samtoolsとSambambaとbiobambam
- CPUスレッド数は全て8
- BAMは全フェーズにおいて圧縮

## eval_combination_03
スレッドを増やした場合の効果
- 上記eval_combination_01との比較
- samtoolsとSambambaとbiobambam
- CPUスレッド数は全て16
- BAMは全フェーズにおいて非圧縮

## eval_combination_04
スレッドを減らした場合の効果
- 上記eval_combination_02との比較
- samtoolsとSambambaとbiobambam
- CPUスレッド数はアライメントが8、それ以外は4
- BAMは全フェーズにおいて圧縮

## eval_combination_05
スレッドの組み合わせ
- bwa | samtools view | Sambamba sort
- CPUスレッド数はアライメントが8、それ以外は可変
- BAMは全フェーズにおいて非圧縮

## eval_combination_06

