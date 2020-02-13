package lib::hiderename;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

my @hidden_modules;

use Module::HideRename;

sub import {
    my ($class, @modules) = @_;

    for my $module (@modules) {
        $module =~ s/\.pm$//; $module =~ s!/!::!g;
        Module::HideRename::hiderename_modules(module => [$module]);
        push @hidden_modules, $module;
    }
}

END {
    Module::HideRename::unhiderename_modules(modules => \@hidden_modules)
          if @hidden_modules;
}

1;
# ABSTRACT: Hide modules by renaming them

=for Pod::Coverage .+

=head1 SYNOPSIS

 use lib::hiderename 'Foo::Bar'; # Foo/Bar.pm will be renamed to Foo/Bar_hidden.pm

 eval { require Foo::Bar }; # will fail

 # Foo/Bar_hidden.pm will be renamed back to Foo/Bar.pm


=head1 DESCRIPTION

EXPERIMENTAL.

lib::hiderename can temporarily hide modules for you, e.g. for testing purposes.
It uses L<Module::HideRename> to rename module files on the filesystem.


=head1 SEE ALSO

L<lib::filter> and L<lib::disallow>, L<Devel::Hide>, L<Test::Without::Module>

L<Module::HideRename>

L<pmhiderename> and L<pmunhiderename> from L<App::pmhiderename>

=cut
