include (EDM)
# generate source code
EDM(RecEvent
    FILES
        RecTrack
        CDRecEvent
        CDTrackRecEvent
        WPRecEvent
        TTRecEvent
        RecHeader
    DEPENDS
        CLHEPDict
        CLHEP
)
