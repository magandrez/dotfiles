CONFIGS := bin config git gpg desktop

all: $(CONFIGS)
$(CONFIGS):
	stow $@

%:
    @: stow $@


.PHONY: % all $(CONFIGS)
