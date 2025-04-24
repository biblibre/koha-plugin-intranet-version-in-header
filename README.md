# Koha plugin to display Koha version in staff interface header

Obsolete since :
Bug 27497: Display Koha version in staff interface home page

## Presentation

Adds JS code to display Koha version YY.MM.XX.YYY in staff interface header.
It is a link to community website https://koha-community.org/category/release/ 

## Packaging

To create KPZ archive from git repository, run the following command:

``git archive --output=../koha-plugin.kpz --format=zip HEAD -- Koha``

