# Assesses the readability score of a document, line-by-line.
import argparse
import textstat

def get_scorer(choice):
    scorers = {
        0: textstat.flesch_reading_ease,
        1: textstat.flesch_kincaid_grade,
        2: textstat.dale_chall_readability_score,
        3: textstat.text_standard
    }
    return scorers[choice]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--scorer', default=0, type=int, help='Readability Scorer')
    ap.add_argument('--input',  help='input file to be scored') 
    ap.add_argument('--output',  help='output file for readability scores')
    ap.add_argument('--summary', default=0, 
            help='whether to calculate average readability score for the test set')
    args = ap.parse_args()

    sentences = [line for line in open(args.input)]
    scorer = get_scorer(args.scorer)
    scores = list(map(lambda x: scorer(x), sentences))
    
    with open(args.output, 'w') as o:
        for score in scores:
            o.write(str(score) + '\n')
        o.close()
    
    if args.summary:
        avg_score = sum(scores) / len(scores)
        summary_f = open(args.output + '.summary', 'w')
        summary_f.write(str(avg_score))
        summary_f.close()

if __name__ == '__main__':
    main()


