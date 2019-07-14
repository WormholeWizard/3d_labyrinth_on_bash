#!/bin/bash

declare TERMINAL_WIDTH
declare TERMINAL_HEIGHT

update_terminal_size()
{
    TERMINAL_WIDTH="$(tput cols)"
    TERMINAL_HEIGHT="$(tput lines)"
}