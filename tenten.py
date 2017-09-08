#! /usr/bin/env python
import json
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('input', type=str, help="JSON file to create new file from.")
    parser.add_argument('output', type=str, help="New file to create.")
    parser.add_argument('--n_feat', type=int, default=10, help="Number of features to keep in new file")
    parser.add_argument('--n_resp', type=int, default=100, help="Number of responses to include in the new file.")

    args = parser.parse_args()

    jout = {}
    with open(args.input, 'r') as f:
        jin = json.load(f)
        for k in jin.keys():
            if k in ['data', 'responseIds']:
                jout[k] = jin[k][:args.n_resp]
                if k == 'data':
                    for i in range(len(jout[k])):
                        jout[k][i] = jout[k][i][:args.n_feat]
            elif k == 'variableNames':
                jout[k] = jin[k][:args.n_feat]
            elif k == 'trainingData':
                jout[k] = {}
                for tk in jin[k].keys():
                    if tk == 'humanScores':
                        jout[k][tk] = jin[k][tk][:args.n_resp]
                    else:
                        jout[k][tk] = jin[k][tk]
                pass
            else:
                jout[k] = jin[k]
    with open(args.output, 'w') as f:
        json.dump(jout, f, indent=4)
