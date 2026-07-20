function conda
    functions --erase conda
    command conda shell.fish hook | source
    conda $argv
end