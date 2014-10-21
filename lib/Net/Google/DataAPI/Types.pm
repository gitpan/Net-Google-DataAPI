package Net::Google::DataAPI::Types;
use Any::Moose;
use Any::Moose '::Util::TypeConstraints';
use Net::Google::DataAPI::Auth::AuthSub;
use Net::Google::AuthSub;
use URI;

our $VERSSION = '0.02';

role_type 'Net::Google::DataAPI::Types::Auth'
    => {role => 'Net::Google::DataAPI::Role::Auth'};

subtype 'Net::Google::DataAPI::Types::AuthSub'
    => as 'Net::Google::AuthSub';

coerce 'Net::Google::DataAPI::Types::Auth'
    => from 'Net::Google::DataAPI::Types::AuthSub'
    => via {
        Net::Google::DataAPI::Auth::AuthSub->new(
            authsub => $_
        );
    };

subtype 'Net::Google::DataAPI::Types::URI'
    => as 'URI';

coerce 'Net::Google::DataAPI::Types::URI'
    => from 'Str'
    => via { URI->new(( m{://} ) ? $_ : ('http://'.$_)) };

__PACKAGE__->meta->make_immutable;

no Any::Moose;
no Any::Moose '::Util::TypeConstraints';

1;
