CONFIGS := bin config fonts git gpg screen x

all: $(CONFIGS)
$(CONFIGS):
	stow $@

%:
    @: stow $@


.PHONY: % all $(CONFIGS)
