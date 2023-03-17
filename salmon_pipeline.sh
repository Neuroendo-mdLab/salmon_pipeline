#!bin/bash

mkdir -p salmon_output

#Define the filename if you have multiple samples that have common part of its filename.
SEQLIBS=(sampleA sampleB)

for seqlib in ${SEQLIBS[@]}; do
	echo -e "Start salmon: ${seqlib}\n"
	#result_dir=${seqlib}_exp_salmon
	salmon	quant -i salmon_ref_index \
		-l A \
		-1 /"Your working directory"/${seqlib}_Read1.out.fq \
		-2 /"Your working directory"/${seqlib}_Read2.out.fq \
		-p 10 \
		-o salmon_output/${seqlib}

	echo -e "Convert sf to csv: ${seqlib}"
        cp ./salmon_output/${seqlib}/quant.sf ./salmon_output/${seqlib}_result.sf
        echo -e "Finished: ${seqlib}"
        head ./salmon_output/${seqlib}_result.sf|column -t
        echo -e "Finish salmon: ${seqlib}\n"
done

python sf_merge_TPM.py
python sf_merge_NumReads.py
