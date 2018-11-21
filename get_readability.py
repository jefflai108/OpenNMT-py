# Assesses the readability score of a document, line-by-line.
import argparse
import textstat

def get_scorer(choice):
    scorers = {
        1: textstat.flesch_reading_ease,
        2: textstat.flesch_kincaid_grade,
        3: textstat.dale_chall_readability_score,
        4: textstat.text_standard
    }
    return scorers[choice]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--scorer', default=1, type=int, help='Readability Scorer')
    ap.add_argument('--input',  help='input file to be scored') 
    ap.add_argument('--output',  help='output file for readability scores') 
    args = ap.parse_args()

    sentences = [line for line in open(args.input)]
    scorer = get_scorer(args.scorer)
    scores = map(lambda x: scorer(x), sentences)
    with open(args.output, 'w') as o:
        map(lambda x: o.write(str(x) + '\n'), scores)

if __name__ == '__main__':
    main()


