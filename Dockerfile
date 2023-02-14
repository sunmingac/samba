FROM alpine

ARG USERNAME
ARG PASSWORD

RUN apk add samba
# RUN mkdir /media/storage && \
#     chmod 0777 /media/storage
RUN addgroup -S sambagroup
RUN echo -e "$PASSWORD\n$PASSWORD" | adduser $USERNAME --ingroup sambagroup
RUN echo -e "$PASSWORD\n$PASSWORD" | smbpasswd -s -a $USERNAME

# COPY smb-append.conf /
# RUN cat /smb-append.conf >> /etc/samba/smb.conf

CMD smbd

EXPOSE 139 445

HEALTHCHECK --interval=60s --timeout=10s \
    CMD smbclient -L \\localhost -U % -m SMB3
