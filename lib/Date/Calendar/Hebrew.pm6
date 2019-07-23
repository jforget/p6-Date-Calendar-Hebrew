use v6.c;
use Date::Calendar::Hebrew::Names;

unit class Date::Calendar::Hebrew:ver<0.0.1>:auth<cpan:JFORGET>;

has Int $.year  where { $_ ≥ 1 };
has Int $.month where { 1 ≤ $_ ≤ 13 };
has Int $.day   where { 1 ≤ $_ ≤ 30 };

method gist {
  sprintf("%04d-%02d-%02d", $.year, $.month, $.day);
}

method month-name {
  Date::Calendar::Hebrew::Names::month-name($.month, $.is-leap);
}

method is-leap {
  is-leap($.year);
}

sub is-leap(Int $year --> Any) {
  return (7 × $year + 1) % 19 < 7;
}

=begin pod

=head1 NAME

Date::Calendar::Hebrew - Conversions from / to the Hebrew calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Hebrew;

=end code

=head1 DESCRIPTION

Date::Calendar::Hebrew  is a  class representing  dates in  the Hebrew
calendar. It allows you ton convert  an Hebrew date into Gregorian (or
possibly other) calendar and the other way.

The Hebrew calendar  is a luni-solar calendar. Some  months are 29-day
long, other are  30-day long and still other varies  between 29 and 30
from a year  to the other, so  on average, the duration of  a month is
very close  to the  duration of a  lunation. The years  have 12  or 13
months, so  while the duration  of the Hebrew year  oscillates between
353 and 385 days,  on average it is very close to  the duration of the
tropic year.

=head1 METHODS

=head2 Constructors

=head3 new

Create an Hebrew date by giving the year, month and day numbers.

=head3 new-from-date

Build an  Hebrew date by  cloning an  object from another  class. This
other   class    can   be    the   core    class   C<Date>    or   any
C<Date::Calendar::xxx> class with a C<daycount> method.

=head3 new-from-daycount

Build an Hebrew date from the Modified Julian Day number.

=head2 Accessors

=head3 year, month, day

The numbers defining the date.

=head3 month-name

The month of the date, as a string.

=head3 day-name

The name of the day within  the week.

=head3 daycount

Convert the date to Modified Julian Day Number (a day-only scheme
based on 17 November 1858).

=head2 Other Methods

=head3 to-date

Clones  the   date  into   a  core  class   C<Date>  object   or  some
C<Date::Calendar::>I<xxx> compatible calendar  class. The target class
name is given  as a positional parameter. This  parameter is optional,
the default value is C<"Date"> for the Gregorian calendar.

To convert a date from a  calendar to another, you have two conversion
styles,  a "push"  conversion and  a "pull"  conversion. For  example,
while converting from the astronomical  date "1 Vendémiaire IV" to the
arithmetic variant, you can code:

=begin code :lang<perl6>

use Date::Calendar::Hebrew;
use Date::Calendar::FrenchRevolutionary;

my  Date::Calendar::Hebrew              $d-orig;
my  Date::Calendar::FrenchRevolutionary $d-dest-push;
my  Date::Calendar::FrenchRevolutionary $d-dest-pull;

$d-orig .= new(year  => 5779
             , month =>    4
             , day   =>   26);
$d-dest-push  = $d-orig.to-date("Date::Calendar::FrenchRevolutionary");
$d-dest-pull .= new-from-date($d-orig);

=end code

When converting I<from> Gregorian, use the pull style. When converting
I<to> Gregorian, use the push style. When converting from any calendar
other than Gregorian  to any other calendar other  than Gregorian, use
the style you prefer.


=head1 PROBLEMS AND KNOWN BUGS

The  validation  of  C<new>  parameters  is  very  basic.  Especially,
checking the month  number ignores the year's nature  (leap or normal)
and you can create a date in Adar II for a normal year. Also, checking
the  day number  ignores the  month value  and you  can create  a 30th
Iyyar, a  30th Tammuz,  a 30th  Elul or  a 30th  Tevet, even  if these
months have only 29 days.

=head1 SEE ALSO

=head2 Perl 5 Software

L<DateTime>

L<DateTime::Calendar::Hebrew>

L<Date::Convert>

L<Date::Hebrew::Simple>

L<Date::Converter>

=head2 Other Software

date(1), strftime(3)

F<calendar/cal-hebrew.el>  in emacs.2  or xemacs.

CALENDRICA 4.0 -- Common Lisp, which can be download in the "Resources" section of
L<https://www.cambridge.org/us/academic/subjects/computer-science/computing-general-interest/calendrical-calculations-ultimate-edition-4th-edition?format=PB&isbn=9781107683167>
(Actually, I have used the 3.0 version which is not longer available)

=head2 Books

Calendrical Calculations (Third or Fourth Edition) by Nachum Dershowitz and
Edward M. Reingold, Cambridge University Press, see
L<http://www.calendarists.com>
or L<https://www.cambridge.org/us/academic/subjects/computer-science/computing-general-interest/calendrical-calculations-ultimate-edition-4th-edition?format=PB&isbn=9781107683167>.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2019 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
