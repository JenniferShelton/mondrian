version development

task concatenate_csv {
    input {
        Array[File] inputfile
        Array[File] inputyaml
    }
    command {
        csverve concat --in_f ~{sep=" --in_f " inputfile} --out_f concat.csv.gz

    }
    output {
        File outfile = "concat.csv.gz"
        File outfile_yaml = "concat.csv.gz.yaml"
    }
    runtime{
        memory: "8G"
        cpu: 1
        walltime: "6:00"
    }
}


task merge_csv{
    input{
        Array[File] inputfiles
        Array[File] inputyamls
        String on
        String how
    }
    command<<<
        csverve merge --in_f ~{sep=" --in_f " inputfiles} --out_f merged.csv.gz --on ~{on} --how ~{how}
    >>>

}



task finalize_csv {
    input {
        Array[File] inputfile
    }
    command {
        variant_utils concat_csv  --inputs ~{sep=" " inputfile} --output concat.csv

    }
    output {
        File outfile = "concat.csv"
    }
    runtime{
        memory: "8G"
        cpu: 1
        walltime: "6:00"
    }
}
