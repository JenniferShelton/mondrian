version 1.0


task extractSplitReads{
    input {
        File inputBam
        String outputBam
        String singularity_dir
    }
    command {
        samtools view -h ~{inputBam} | lumpy_extractSplitReads_BwaMem -i stdin | samtools view -Sb - > ~{outputBam}
    }
    output {
        File bamFile = outputBam
    }
    runtime{
        memory: "8 GB"
        cpu: 1
        walltime: "48:00"
        docker: 'quay.io/mondrianscwgs/breakpoint:v0.0.2'
        singularity: '~{singularity_dir}/breakpoint_v0.0.2.sif'
    }
}


task lumpyExpress{
    input{
        File normalSplitBam
        File tumourSplitBam
        File normalDiscBam
        File tumourDiscBam
        File normal_bam
        File tumour_bam
        String singularity_dir
    }
    command{
        lumpyexpress -B ~{normal_bam},~{tumour_bam} -S ~{normalSplitBam},~{tumourSplitBam} -D ~{normalDiscBam},~{tumourDiscBam} -o lumpy.vcf
    }
    output{
        File lumpy_vcf = 'lumpy.vcf'
    }
    runtime{
        memory: "8 GB"
        cpu: 1
        walltime: "48:00"
        docker: 'quay.io/mondrianscwgs/breakpoint:v0.0.2'
        singularity: '~{singularity_dir}/breakpoint_v0.0.2.sif'
    }
}