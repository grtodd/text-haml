#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 4;

use Text::Haml;

my $haml = Text::Haml->new;

# :escaped
my $output = $haml->render(<<'EOF');
:escaped
  <&">
EOF
is($output, <<'EOF');
&lt;&amp;&quot;&gt;
EOF

# :plain
$output = $haml->render(<<'EOF');
:plain
  This is a plain text.
EOF
is($output, <<'EOF');
This is a plain text.
EOF

# :preserve
$output = $haml->render(<<'EOF');
:preserve
  No empty line
  is ignored.
%p
EOF
is($output, <<'EOF');
No empty line&#x000A;is ignored.
<p></p>
EOF

# :javascript
$output = $haml->render(<<'EOF');
:javascript
  alert('boo');
%p
EOF
is($output, <<'EOF');
<script type='text/javascript'>
  //<![CDATA[
    alert('boo');
  //]]>
</script>
<p></p>
EOF