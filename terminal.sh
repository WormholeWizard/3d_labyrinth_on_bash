#!/bin/bash

update_terminal_size()
{
    OUT_WIDTH="$(tput cols)"
    OUT_HEIGHT="$(tput lines)"
}

update_terminal_size