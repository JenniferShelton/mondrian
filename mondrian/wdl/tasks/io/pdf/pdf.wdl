version 1.0



task MergePdf{
    input{
        Array[File] infiles
        String filename_prefix
    }
    command<<<
        pdf_utils merge_pdfs --infiles ~{sep=" "infiles} --outfile ~{filename_prefix}.pdf
    >>>
    output{
        File merged = '~{filename_prefix}.pdf'
    }
    runtime{
        memory: "8 GB"
        cpu: 1
        walltime: "6:00"
        docker: 'quay.io/mondrianscwgs/hmmcopy:v0.0.2'
        singularity: '~{singularity_dir}/alignment_v0.0.2.sif'
    }
}