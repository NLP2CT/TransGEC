import numpy as np
import re
import shutil

from fairseq.tokenizer import tokenize_line

class NoiseInjector(object):

    # def __init__(self, corpus, shuffle_sigma=0.5,
    #              replace_mean=0.1, replace_std=0.03,
    #              delete_mean=0.1, delete_std=0.03,
    #              add_mean=0.1, add_std=0.03):
    def __init__(self, corpus, shuffle_sigma=0.5,
                 replace_mean=0.2, replace_std=0.03,
                 delete_mean=0.1, delete_std=0.03,
                 add_mean=0.05, add_std=0.03):
        # READ-ONLY, do not modify
        self.corpus = corpus
        self.shuffle_sigma = shuffle_sigma
        self.replace_a, self.replace_b = self._solve_ab_given_mean_var(replace_mean, replace_std**2)
        self.delete_a, self.delete_b = self._solve_ab_given_mean_var(delete_mean, delete_std**2)
        self.add_a, self.add_b = self._solve_ab_given_mean_var(add_mean, add_std**2)

    @staticmethod
    def _solve_ab_given_mean_var(mean, var):
        a = mean * mean * (1. - mean) / var - mean
        b = (1. - mean) * (mean * (1. - mean) / var - 1.)
        return a, b

    def _shuffle_func(self, correct):
        if self.shuffle_sigma < 1e-6:
            return correct

        shuffle_key = [i + np.random.normal(loc=0, scale=self.shuffle_sigma) for i in range(len(correct))]
        new_idx = np.argsort(shuffle_key)
        res = [correct[i] for i in new_idx]
            
        return res

    def _replace_func(self, correct):
        replace_ratio = np.random.beta(self.replace_a, self.replace_b)
        ret = []
        rnd = np.random.random(len(correct))
        for i, p in enumerate(correct):
            if rnd[i] < replace_ratio: 
                rnd_ex = self.corpus[np.random.randint(len(self.corpus))]
                rnd_word = rnd_ex[np.random.randint(len(rnd_ex))]
                ret.append((-1, rnd_word))
            else:
                ret.append(p)
        return ret

    def _delete_func(self, correct):
        delete_ratio = np.random.beta(self.delete_a, self.delete_b)
        ret = []
        rnd = np.random.random(len(correct))
        for i, p in enumerate(correct):
            if rnd[i] < delete_ratio:
                continue
            ret.append(p)
        return ret

    def _add_func(self, correct):
        add_ratio = np.random.beta(self.add_a, self.add_b)
        ret = []
        rnd = np.random.random(len(correct))
        for i, p in enumerate(correct):
            if rnd[i] < add_ratio:
                rnd_ex = self.corpus[np.random.randint(len(self.corpus))]
                rnd_word = rnd_ex[np.random.randint(len(rnd_ex))]
                ret.append((-1, rnd_word))
            ret.append(p)

        return ret

    def _parse(self, pairs):
        align = []
        art = []
        for si in range(len(pairs)):
            ti = pairs[si][0]
            w = pairs[si][1]
            art.append(w)
            if ti >= 0:
                align.append('{}-{}'.format(si, ti))
        return art, align

    def inject_noise(self, tokens):
        # correct is a vector of integers

        funcs = [self._add_func, self._shuffle_func, self._replace_func, self._delete_func]
        np.random.shuffle(funcs)
        
        pairs = [(i, w) for (i, w) in enumerate(tokens)]
        for f in funcs:
            pairs = f(pairs)
            art, align = self._parse(pairs)

        return self._parse(pairs)


def save_file(filename, contents):
    with open(filename, 'w') as ofile:
        for content in contents:
            ofile.write(' '.join(content) + '\n')

# make noise from filename
def noise(filename, ofile_suffix):
    lines = open(filename).readlines()
    corrects = [tokenize_line(line.strip()) for line in lines]
    noise_injector = NoiseInjector(corrects)
    
    errors = []
    aligns = []
    for correct in corrects:
        error, align = noise_injector.inject_noise(correct)
        errors.append(error)
        aligns.append(align)
    
    save_file('{}.error'.format(ofile_suffix), errors)
    save_file('{}.correct'.format(ofile_suffix), corrects)
    save_file('{}.forward'.format(ofile_suffix), aligns)

import argparse

parser=argparse.ArgumentParser()
parser.add_argument('-e', '--epoch', type=int, default=10)
parser.add_argument('-s', '--seed', type=int, default=2468)

args = parser.parse_args()
np.random.seed(args.seed)
if __name__ == '__main__':
    print("epoch={}, seed={}".format(args.epoch, args.seed))

    


    filename = "Your-path/translationese" # path for your translationese or native texts or mix texts
    ofile_suffix = "Your-path/translationese_{}".format(args.epoch) # path for synthetic data: translationese_error translationese_correct

    # filename = "Your-path/native-data" # path for your translationese or native texts
    # ofile_suffix = "Your-path/native_{}".format(args.epoch) # path for synthetic data: native_error native_correct

    # filename = "Your-path/mix-data" # path for your translationese or native texts or mix texts
    # ofile_suffix = "Your-path/mix_{}".format(args.epoch) # path for synthetic data: mix_error mix_correct








    noise(filename, ofile_suffix)

