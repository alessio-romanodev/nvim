
````markdown
# 🧠 Cheat Sheet – Sistemi Operativi
## IPC System V, Processi e Thread (da esame)

---

## 🔹 fork()
Crea un nuovo processo (figlio).

```c
pid_t fork(void);
````

**Valore di ritorno**

* `0` → processo figlio
* `>0` → PID del figlio (nel padre)
* `-1` → errore

**Esempio**

```c
pid_t pid = fork();
if (pid == 0)
    printf("Figlio\n");
else
    printf("Padre\n");
```

---

## 🔹 wait()

Attende la terminazione di un processo figlio.

```c
pid_t wait(int *status);
```

**Valore di ritorno**

* PID del figlio terminato
* `-1` → errore

**Esempio**

```c
wait(NULL);
```

---

## 🔹 pthread_create()

Crea un thread.

```c
int pthread_create(
    pthread_t *thread,
    const pthread_attr_t *attr,
    void *(*start_routine)(void *),
    void *arg
);
```

**Valore di ritorno**

* `0` → successo
* `!= 0` → errore

**Esempio**

```c
pthread_t t;
pthread_create(&t, NULL, funzione_thread, arg);
```

---

## 🔹 pthread_join()

Attende la terminazione di un thread.

```c
int pthread_join(pthread_t thread, void **retval);
```

**Valore di ritorno**

* `0` → successo
* `!= 0` → errore

**Esempio**

```c
pthread_join(t, NULL);
```

---

## 🔹 msgget()

Crea o apre una coda di messaggi (System V).

```c
int msgget(key_t key, int msgflg);
```

**Valore di ritorno**

* ID della coda
* `-1` → errore

**Esempio**

```c
int id = msgget(key, IPC_CREAT | 0666);
```

---

## 🔹 msgsnd()

Invia un messaggio in una coda.

```c
int msgsnd(int msqid, const void *msgp, size_t msgsz, int msgflg);
```

**Valore di ritorno**

* `0` → successo
* `-1` → errore

⚠️ `msgsz` NON include il campo `long type`.

**Esempio**

```c
messaggio msg;
msg.type = 1;
msg.val = 10;

msgsnd(id, &msg, sizeof(msg) - sizeof(long), 0);
```

---

## 🔹 msgrcv()

Riceve un messaggio da una coda.

```c
ssize_t msgrcv(
    int msqid,
    void *msgp,
    size_t msgsz,
    long msgtyp,
    int msgflg
);
```

**Valore di ritorno**

* numero di byte ricevuti
* `-1` → errore

**Esempio**

```c
msgrcv(id, &msg, sizeof(msg) - sizeof(long), 1, 0);
```

---

## 🔹 msgctl()

Controllo o rimozione di una coda di messaggi.

```c
int msgctl(int msqid, int cmd, struct msqid_ds *buf);
```

**Comandi comuni**

* `IPC_RMID` → rimuove la coda

**Esempio**

```c
msgctl(id, IPC_RMID, NULL);
```

---

## 🔹 shmget()

Crea o apre un segmento di memoria condivisa.

```c
int shmget(key_t key, size_t size, int shmflg);
```

**Valore di ritorno**

* ID del segmento
* `-1` → errore

**Esempio**

```c
int shmid = shmget(key, 1024, IPC_CREAT | 0666);
```

---

## 🔹 shmat()

Aggancia un segmento di memoria condivisa.

```c
void *shmat(int shmid, const void *shmaddr, int shmflg);
```

**Valore di ritorno**

* puntatore alla memoria
* `(void *) -1` → errore

**Esempio**

```c
int *ptr = (int *) shmat(shmid, NULL, 0);
```

---

## 🔹 shmctl()

Controllo o rimozione memoria condivisa.

```c
int shmctl(int shmid, int cmd, struct shmid_ds *buf);
```

**Comandi comuni**

* `IPC_RMID` → rimuove il segmento

**Esempio**

```c
shmctl(shmid, IPC_RMID, NULL);
```

---

## 🔹 semget()

Crea o apre un set di semafori.

```c
int semget(key_t key, int nsems, int semflg);
```

**Valore di ritorno**

* ID del set
* `-1` → errore

**Esempio**

```c
int semid = semget(key, 1, IPC_CREAT | 0666);
```

---

## 🔹 semctl()

Controllo e inizializzazione di un semaforo.

```c
int semctl(int semid, int semnum, int cmd, ...);
```

**Comandi comuni**

* `SETVAL` → inizializza
* `IPC_RMID` → rimuove

**Esempio**

```c
semctl(semid, 0, SETVAL, 1);
```

---

## 🔹 semop()

Esegue operazioni P/V su semafori.

```c
int semop(int semid, struct sembuf *sops, size_t nsops);
```

**Esempio**

```c
struct sembuf p = {0, -1, 0};
semop(semid, &p, 1);
```


