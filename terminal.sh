#!/bin/bash

update_terminal_size()
{
    TERMINAL_WIDTH="$(tput cols)"
    TERMINAL_HEIGHT="$(tput lines)"
}

update_terminal_size