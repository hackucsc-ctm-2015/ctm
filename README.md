# ctm

         OSLDB: The Open Source Literate Dynabook
         ----------------------------------------

Based on concepts from: Saint R. Stallman, Donald Knuth, and Alan Kay

Big Idea: Education is at the forefront of the social worries of our country
and all other countries.  We claim the effective math education needs to 
be dynamic and interactive, and the paradigms of the past are substandard for
todays technology.  We believe that the age of the paperless office will do 
much more than save trees, it will engage students, allowing them to be active 
participants in their own education.  Re-writing the texts of the past into 
this interactive environment will be a large undertaking.  We propose that the
Open Source paradigm is the ideal paradigm to create powerful interactive 
text books and curriculums.

This will make computing devices all mobile devices, and the web all 1st class
participants in improving the educational landscape.

...
The vision from Alan Kay of the Dynabook and Open Source by Richard
Stallman in the early 80's can fuse together by creating an open source
textbook, that also tries to address the concept of literate programming
as proposed by Donald Knuth.  We like the idea that the code that implements
the book be as open-source as the book.  A concept that Richard Stallman
has certainly preached.
...

For this vision to happen authors need new tools that help them make interactive
text books with dynamic mathematical equations, plots, multi-media and
all sorts of participation by the students.  This is the "Dyna" in Dynabook.

Similar concepts are being explored by UC Berkeley in the creation of the
IPyNotebook.  One of their laudable concepts is that a Ph.D. Thesis can and 
should be presented in IPython Notebook and that will be capable of include a 
dynamic demonstration and testable code.

Our group has prototyped a new language/system during this hackathon weekend 
capable of seamlessly blending together formatted markdown input (i.e. easily
formatted notes, add images, html mathjax, and more)  It will work on any
device that supports HTML5 and Javascript.  Thus by its very nature it is 
device independent, a modern browser is all that is needed.   The simplicity 
of the system, allows for greater scrutiny with regards to security. Since
it uses only client-side Javascript, the system is as scalable as static HTML.
It is in the nature of scalability, simplicity, and ease of use that we think
our approach is better.  Pytnon or other languages are not required. Javascript
(with many skins) has become the recognized language of choice for the web, 
leveraging the power of Modern Browsers.

Our very simple Open-Source Literate Dynabook is of course still just a prototype,
as developed at the 2015 UCSC HACKATHON over a weekend.  This and the IPython
Notebook Demo are basically ilustrative and creates a seed for what open source
programmer may want to use.

Such blend of open source code, literate programming, dynamic authoring, 
should help bring together at last the vision started long ago.

     "The best way to predict the future is to invent it", A.Kay

-----------------------------------------
MORE ON THIS:

"When Alan Kay was asked if the Dynabook has not, in fact, been realized in
the form of the notebook computer, tablet, and smartphone, Kay said he
believes those devices largely miss the point.   Apple's iPad — and the wider 
computing environment, by extension — falls short of the Dynabook's ideal, 
Kay says, since it lacks the capacity to enable "symmetric authoring and consuming." (1)
...

"Kay's harsh words weren't reserved just for Apple. The computing pioneer took
issue with the larger computing industry in general, in particular the ways
computers are integrated into education." (1)

Alan Kay's critique is valid still today.  The innovation of our project is
intended to address this problem.  We believe the Open Source paradigm combined
with literate programming is a great way for a community to address the human 
challenge of teaching mathematics and other fields to a wider audience.

About old ideas that morph into new ideas.
------------------------------------------

OPEN SOURCE: Saint Richard Stallman 

The Open Source community and concept that Richard Stallman pioneered, was not
developed or motivated around the idea of how to make more money, but with the
idea that human beings are where they are in the evolutionary landscape because 
we have learnt to cooperate.   So all of us as human beings need to continue
to learn that sharing our work is a good thing.  So making tools that allows us
to share and improves our knowledge is a powerful concept. 

LITERATE PROGRAMMING: Donald Knuth

Donald Knuth is known for having written the authoritative set of text books
on Computer Algorithms, and is known for having written the predominant software 
used today by academics to help write and format text books and papers, the 
TeX system.  He also wrote a paper called Literate Programming that espoused 
the concept that programs should read like books.  This implies among other 
things the idea was that you could have code 

THE DYNABOOK: Alan Kay

"Kay wanted the Dynabook concept to embody the learning theories of Jerome Bruner 
and some of what Seymour Papert— who had studied with developmental psychologist 
Jean Piaget and who was one of the inventors of the Logo programming language — 
was proposing."

So I will end the description of our Hackathon project with another interesting
idea.   If you want to innovate and you feel stuck, look to the past. 


Team Members:
   Marcelo Siero
   Christopher Schuster
   Tommy ...

==============================================================================
Features of our software:
   Software is very light weight (160 lines of the main JS source code)
   Very scalable, no server side - interaction is necessary.
   Portable across platforms and devices (Uses only HTML5, Javascript, 
   Easy formatting: Markdown + Easy Code Visibility and Invisibility.

(1) http://appleinsider.com/articles/13/04/03/computing-pioneer-alan-kay-calls-apples-ipad-user-interface-poor

