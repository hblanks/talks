==========================================
What I talk about when I talk about Python
==========================================

Prologue
--------

I visited an old friend and former colleague in Boston this past
January. It happens that we've both had the chance to work with a
particularly extraordinary engineer, and when our conversation turned to
him and how he was doing, it naturally also turned to the topic of what
it's been like to work with him. Matt first asked me, "Does he still
leave those comments in his code?" and then he told this story, which
marks the beginning of this talk.

In the great dot-com boom, Matt and the extraordinary engineer are both
working at a streaming video startup in the Bay Area. The hours are no
doubt untenable, and the business will ultimately fail after a nearly
uncountable number of financing rounds. Nevertheless, the technology is
great, there are hard problems to work on, and there are exceptionally
smart people to work with.

One night or morning, Matt comes across a piece of code -- or rather, a
giant comment block, followed by just three or four lines of C. The few
executable lines don't seem to make any sense by themselves: there's
some strange assembly language op that gets called, and after that a
pointer reassignment of some kind.  But the comment explains it: the
following lines call an uncommon CPU instruction for applying bitwise
operations to a matrix. If this instruction is not available, the CPU
can only return to the earlier address after first executing some
additional instruction. The few lines thus call the instruction, and in
the event that it failed, they alter the bits at the original address so
that it no longer contains the missing instruction, but rather some
instruction that does nothing.

The code itself was no doubt extraordinary -- as Matt put it, it's not
every day that you come across something quite as remarkable as a
high-performance optimization involving self-modifying C code. Yet two
other things about it struck me as even more remarkable: first, the fact
that Matt and I found ourselves talking about a piece of software that
has long since become obsolete, from a company that imploded nearly a
decade ago, and second, the fact that if the author had not gone to the
trouble of explaining what he had done, we would have never known about
it, nor been able to learn anything from it.

It is for these two things, then, that I told this story. Together, they
sit at the heart of what I talk about when I talk about Python.


Part 1. Rabinow, Sloterdijk, Jean-Paul
--------------------------------------

Let us turn to two citations, first from the anthropologist Paul
Rabinow:

    Additionally, and unexpetedly, this book addresses the reader as a
    friend. Initially this alleation too is opaque. However, ...

    XXX

    [Rabinow. *Anthropos Today*, 2003. p. 1.]

and then from German intellectual Peter Sloterdijk, whom Rabinow cites
in the footnote above:

    «Les livres», observa un jour le poète Jean-Paul, «sont des longues
    lettres ä des amis.

    XXX

    [Sloterdijk. "Régles pour la parc humaine". Translated by Olivier
    Mannouni.]

