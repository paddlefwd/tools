#! /usr/bin/env python
import os
import sys
import argparse

if not os.getcwd() in sys.path:
    sys.path.insert(1, os.getcwd())
sys.path.insert(1, "/Users/crank/repos/111-utils")
from components import clone

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Clone a comma separated list of prompts.")
    parser.add_argument('prompt', help="The TDS scoring prompt name to clone")
    parser.add_argument('--tag', help="Alternate tag ", default="chr")
    parser.add_argument('--preview', help="List prompts to clone only", action='store_true')
    args = parser.parse_args()
    for p in [x.strip() for x in args.prompt.split(',')]:
        new_p = "%s_%s" % (p, args.tag)
        print("Cloning prompt %s to %s" % (p, new_p))
        if not args.preview:
            clone.prompt_with_responses(prompt_id=p, new_prompt_id=new_p,
                                        source_tds_url='https://dev-training.ktscoringservices.com',
                                        source_tds_key='b082e716-156a-4b4a-a2f8-45f9816067cd',
                                        dest_tds_url='https://dev-training.ktscoringservices.com',
                                        dest_tds_key='b082e716-156a-4b4a-a2f8-45f9816067cd',
                                        no_preserve_uuids=True)
