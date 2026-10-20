# iso8601 — reconstructed outline of CrossOver 26.3 lib/python/iso8601.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""ISO 8601 date time string parsing

Basic usage:
>>> import iso8601
>>> iso8601.parse_date("2007-01-25T12:00:00Z")
datetime.datetime(2007, 1, 25, 12, 0, tzinfo=<iso8601.iso8601.Utc ...>)
>>>

"""
from datetime import datetime
from datetime import timedelta
from datetime import tzinfo
import re
__all__ = ['parse_date', 'ParseError']
ISO8601_REGEX = re.compile('(?P<year>[0-9]{4})(-(?P<month>[0-9]{1,2})(-(?P<day>[0-9]{1,2})((?P<separator>.)(?P<hour>[0-9]{2}):(?P<minute>[0-9]{2...)
TIMEZONE_REGEX = re.compile('(?P<prefix>[+-])(?P<hours>[0-9]{2}).(?P<minutes>[0-9]{2})')
class ParseError(Exception):
    """Raised when there is a problem parsing a date string"""

ZERO = timedelta(0)
class Utc(tzinfo):
    """UTC

    """
    def utcoffset(self, _dt):
        # globals: ZERO
        ...

    def tzname(self, _dt):
        # strings: 'UTC'
        ...

    def dst(self, _dt):
        # globals: ZERO
        ...


UTC = Utc()
class FixedOffset(tzinfo):
    """Fixed offset in hours and minutes from UTC

    """
    def __init__(self, offset_hours, offset_minutes, name):
        # globals: timedelta
        # attributes: _FixedOffset__offset, _FixedOffset__name
        ...

    def utcoffset(self, _dt):
        # attributes: _FixedOffset__offset
        ...

    def tzname(self, _dt):
        # attributes: _FixedOffset__name
        ...

    def dst(self, _dt):
        # globals: ZERO
        ...

    def __repr__(self):
        # attributes: _FixedOffset__name
        # strings: '<FixedOffset %r>'
        ...


def parse_timezone(tzstring, default_timezone=UTC):
    """Parses ISO 8601 time zone specs into tzinfo offsets

    """
    # globals: TIMEZONE_REGEX, int, FixedOffset
    # attributes: match, groups
    # strings: 'Z', '-'
    ...

def parse_date(datestring, default_timezone=UTC):
    """Parses ISO 8601 dates into datetime objects

The timezone is parsed from the date string. However it is quite common to
have dates without a timezone (not strictly correct). In this case the
default timezone specified in default_timezone is used. This is UTC by
default.
"""
    # globals: isinstance, str, ParseError, ISO8601_REGEX, parse_timezone, int, float, datetime
    # attributes: match, groupdict
    # strings: 'Expecting a string %r', 'Unable to parse date string %r', 'timezone', 'fraction', '0.%s', 'year', 'month', 'day', 'hour', 'minute', 'second'
    ...
