#!/bin/bash

awk '
function inrange(r){
  return (r>=7 && r<=55)
}
{
  r1=$4; r2=$6
  if (inrange(r1) && inrange(r2)) print
}
' out_bb_edited2 > out_bb_dmn1_edited


awk '
function inrange(r){
  return (r>=108 && r<=155)
}
{
  r1=$4; r2=$6
  if (inrange(r1) && inrange(r2)) print
}
' out_bb_edited2 > out_bb_dmn2_edited

