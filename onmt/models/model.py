""" Onmt NMT Model base class definition """
import torch.nn as nn


class NMTModel(nn.Module):
    """
    Core trainable object in OpenNMT. Implements a trainable interface
    for a simple, generic encoder + decoder model.

    Args:
      encoder (:obj:`EncoderBase`): an encoder object
      decoder (:obj:`RNNDecoderBase`): a decoder object
      multi<gpu (bool): setup for multigpu support
    """

    def __init__(self, encoder, decoder0, decoder1=None):
        super(NMTModel, self).__init__()
        self.encoder = encoder
        self.decoder0 = decoder0
        self.decoder1 = decoder1

    def forward(self, src, tgt, lengths, dec_num=0):
        """Forward propagate a `src` and `tgt` pair for training.
        Possible initialized with a beginning decoder state.

        Args:
            src (:obj:`Tensor`):
                a source sequence passed to encoder.
                typically for inputs this will be a padded :obj:`LongTensor`
                of size `[len x batch x features]`. however, may be an
                image or other generic input depending on encoder.
            tgt (:obj:`LongTensor`):
                 a target sequence of size `[tgt_len x batch]`.
            lengths(:obj:`LongTensor`): the src lengths, pre-padding `[batch]`.
            dec_num (int): Which decoder to use.
        Returns:
            (:obj:`FloatTensor`, `dict`, :obj:`onmt.Models.DecoderState`):

                 * decoder output `[tgt_len x batch x hidden]`
                 * dictionary attention dists of `[tgt_len x batch x src_len]`
        """
        tgt = tgt[:-1]  # exclude last target from inputs

        enc_state, memory_bank, lengths = self.encoder(src, lengths)
        
        # Select the decoder to pair
        if self.decoder1 and dec_num:
            self.decoder1.init_state(src, memory_bank, enc_state)
            dec_out, attns = self.decoder1(tgt, memory_bank,
                    memory_lengths=lengths)
        else:
            self.decoder0.init_state(src, memory_bank, enc_state)
            dec_out, attns = self.decoder0(tgt, memory_bank,
                    memory_lengths=lengths)

        return dec_out, attns


